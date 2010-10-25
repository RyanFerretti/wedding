class WelcomeController < ApplicationController

  def index
    @tweet = "Twitter is giving us problems!"#get_tweet_from_twitter()
  end

private

  def get_tweet_from_twitter
    conn = Faraday::Connection.new(:url => 'http://api.twitter.com/1') do |builder|
      builder.adapter Faraday.default_adapter
      builder.use Faraday::Response::MultiJson
      builder.use Faraday::Response::Mashify
    end

    resp = conn.get do |req|
      req.url '/statuses/user_timeline.json', :screen_name => 'julie_and_ryan', :count => '1'
    end

    resp.body[0].text
  end
end
