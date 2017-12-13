require 'twitter'

class TwitterService
  attr_reader :client

  def initialize(user, provider)
    @user = user
    @provider = provider
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV["TWITTER_API_KEY"]
      config.consumer_secret     = ENV["TWITTER_API_SECRET"]
      config.access_token        = ENV["TWITTER_TOKEN"]
      config.access_token_secret = ENV["TWITTER_TOKEN_SECRET"]
    end
  end

  def get_all_tweets_from_user(user)
    @client.search("from:#{user}", result_type: "recent").take(10).collect do |tweet|
      id = tweet.id
      name = tweet.user.name
      link = "https://www.twitter.com/#{name}/status/#{id.to_s}"
      results = Result.new(
        link: link,
        total_likes: tweet.retweet_count,
        provider: @provider,
        user: @user,
        category: "twitter-from",
        text: tweet.text,
        created_time: tweet.created_at,
        avatar: tweet.user.profile_image_url_https,
        username: tweet.user.screen_name
        )
      results.provider = @provider
      results.save!
    end
  end

  def get_all_tweets_to_user(user)
    @client.search("to:#{user}", result_type:"recent").take(10).collect do |tweet|
      id = tweet.id
      name = tweet.user.name
      link = "https://www.twitter.com/#{name}/status/#{id.to_s}"
      results = Result.new(
        link: link,
        total_likes: tweet.retweet_count,
        provider: @provider,
        user: @user,
        category: "twitter-to",
        text: tweet.text,
        created_at: tweet.created_at,
        avatar: tweet.user.profile_image_url_https,
        username: tweet.user.screen_name,
        )
      results.provider = @provider
      results.save!
    end
  end
end


