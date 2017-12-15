require 'sidekiq-scheduler'

class TwitterJob < ApplicationJob
  queue_as :default

  def perform
    User.find_each do |user|
      begin
        provider = user.providers.find_by(name: 'twitter')
        if provider && provider.try(:username)
          infos = TwitterService.new(user, provider)
          infos.get_all_tweets_from_user(provider.username)
          infos.get_all_tweets_to_user(provider.username)
        end
      rescue Twitter::Error::TooManyRequests => e
        puts e
      end
    end
  end
end
