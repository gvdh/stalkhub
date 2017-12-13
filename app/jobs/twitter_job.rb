class TwitterJob < ApplicationJob
  queue_as :default

  def perform(username, user_id)
    user = User.find(user_id)
    infos = TwitterService.new(user)
    infos.get_all_tweets_from_user(username)
    infos.get_all_tweets_to_user(username)
  end
end
