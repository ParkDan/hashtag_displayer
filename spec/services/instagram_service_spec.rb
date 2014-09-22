require 'spec_helper'

describe InstagramService do
  it 'returns Grams' do
    expect(GramFactory).to receive(:make_grams).with(SampleInstagramResponses.instagram_response)
    sleep ENV["API_Rate"].to_i + 0.5
    InstagramService.instance.get_grams_by_hashtag("#{ENV["HASHTAG"]}")
  end
end