class TwitterJob < ApplicationJob
  queue_as :default

  def perform(params, user)
    infos = TwitterService.new(params, user)
    infos.get_all_tweets_from_user(params["twitter_username"])
    infos.get_all_tweets_to_user(params["twitter_username"])
  end
end
