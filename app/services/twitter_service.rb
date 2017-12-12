require 'twitter'

class TwitterService
  attr_reader :client

  def initialize(params, user)
    @user = user
    @provider = Provider.create!(
      name: "twitter",
      expires_at: 9999999999,
      user: user
      )
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV["TWITTER_API_KEY"]
      config.consumer_secret     = ENV["TWITTER_API_SECRET"]
      config.access_token        = ENV["TWITTER_TOKEN"]
      config.access_token_secret = ENV["TWITTER_TOKEN_SECRET"]
    end
  end

  def get_all_tweets_from_user(user)
    @client.search("from:#{user}", result_type: "recent").take(50).collect do |tweet|
      results = Result.new(
        provider: @provider,
        user: @user,
        category: "twitter",
        text: tweet.text,
        created_at: tweet.created_at,
        name: tweet.user.screen_name
        )
      results.provider = @provider
      results.save!
    end
  end

  def get_all_tweets_to_user(user)
    @client.search("to:#{user}", result_type:"recent").take(50).collect do |tweet|
      results = Result.new(
        provider: @provider,
        user: @user,
        category: "twitter",
        text: tweet.text,
        created_at: tweet.created_at,
        name: tweet.user.screen_name
        )
      results.provider = @provider
      results.save!
    end
  end
end




