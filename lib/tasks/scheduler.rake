desc "This task is called by the Heroku scheduler add-on"
task :update_feed => :environment do
  Rails.application.eager_load!
  puts "Updating feed..."
  puts "*" * 80
  TweetService.get_tweets_by_hashtag ENV["HASHTAG"]
  # NewsFeed.update
  puts "done."
end

namespace :db do
	task :clear_half_db => :environment do
	  Rails.application.eager_load!
	  puts "Clearing old posts..."
	  old_posts = Post.order(time_of_post: :desc).first(Post.all.count/2)
	  old_posts.each(&:destroy)
	  puts "done."
	end
end

