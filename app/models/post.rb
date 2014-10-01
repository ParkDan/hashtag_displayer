class Post < ActiveRecord::Base
	validates_presence_of :screen_name, :time_of_post,
	 					:profile_image_url, :source

	validates_uniqueness_of :screen_name, scope: :time_of_post

  def as_json(options={})
    super.as_json().merge({formatted_time_of_post: time_of_post})
  end

  def self.get_new_posts(hashtag)
    if APIService.instance.pull_posts(hashtag)
      order(time_of_post: :desc).select { |post| is_post_from_last_pull?(post) }
    else
      nil
    end
  end

  def ==(post)
    text == post.text &&
    screen_name == post.screen_name &&
    time_of_post == post.time_of_post &&
    media_url == post.media_url &&
    source == post.source
  end

  def self.all(hashtag=false)
    APIService.instance.pull_posts(hashtag) if hashtag
    super()
  end

  def self.tweets
    where(source: "twitter")
  end

  def self.grams
    where(source: "instagram")
  end

  def self.newest_fifty_posts(hashtag=false)
    all(hashtag).order(time_of_post: :desc).limit(50)
  end

  def self.next_fifty_posts(last_post_id)
    last_post = find(last_post_id)
    where("time_of_post < ?", last_post.time_of_post).order(time_of_post: :desc).limit(50)
  end


private

  def self.is_post_from_last_pull?(post)
    post.created_at > APIService.instance.last_update
  end
end
