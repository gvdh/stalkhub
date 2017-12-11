require 'twitter'


class TwitterService
  attr_reader :client

  def initialize(params, user)
    @user = user
    @provider = Provider.create!(
      name: "twitter",
      # expires_at: 9999999999,
      user: user
      )
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key        = "SyNM5rSQWjSKjaPp8uNj1WuGq"
      config.consumer_secret     = "jf09gkT0s7c13yCBpZOM4dkE6gZ5TnroRmYvO9PtrOLWomzYMp"
      config.access_token        = "939486158668607490-XE1gGFo2Bwg9spPsW72bQFnsP0kYQBD"
      config.access_token_secret = "QjNPSLHDy35xTRNwzWNgGzuMqDbhOZG327PQGD0EKY1kl"
    end
  end

  def get_all_tweets_from_user(user)
    @client.search("from:#{user}", result_type: "recent").take(50).collect do |tweet|
      results = Result.new(
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






