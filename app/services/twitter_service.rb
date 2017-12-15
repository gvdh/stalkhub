require 'twitter'

class Renderer
  def renderer
    controller = ApplicationController.new
    controller.request = ActionDispatch::TestRequest.new
    ViewRenderer.new(Rails.root.join('app', 'views'), {}, controller)
  end
end

# app/services/view_renderer.rb
# A helper class for Renderer
class ViewRenderer < ActionView::Base
  include Rails.application.routes.url_helpers
  include ApplicationHelper

  def default_url_options
     {host: Rails.application.routes.default_url_options[:host]}
  end
end

class TwitterService
  include ActionView::Helpers

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
      if Result.find_by_node_id(id).nil? || Result.find_by_node_id(id).user != @user
        r = Result.new(
          node_id: id,
          link: link,
          total_likes: tweet.retweet_count,
          provider: @provider,
          user: @user,
          category: "twitter-from",
          text: tweet.text,
          created_time: tweet.created_at,
          avatar: tweet.user.profile_image_url_https,
          username: tweet.user.screen_name,
          )

        r.provider = @provider

        if r.save
          tpl = ApplicationController.render(
                  template: 'shared/_muuri_result',
                  locals: { result: r },
                  layout: false
                )
          TwitterChannel.broadcast_to @user, tpl
        else
          puts "Creation of result #{id} failed !"
        end
      else
        puts "Result already exists !"
      end
    end
  end

  def get_all_tweets_to_user(user)
    @client.search("to:#{user}", result_type:"recent").take(10).collect do |tweet|
      id = tweet.id
      name = tweet.user.name
      link = "https://www.twitter.com/#{name}/status/#{id.to_s}"

      if Result.find_by_node_id(id).nil? || Result.find_by_node_id(id).user != @user
        begin
          results = Result.new(
            node_id: id,
            link: link,
            total_likes: tweet.retweet_count,
            provider: @provider,
            user: @user,
            category: "twitter-to",
            text: tweet.text,
            created_time: tweet.created_at,
            avatar: tweet.user.profile_image_url_https,
            username: tweet.user.screen_name,
            )
          results.provider = @provider
          results.save!
          tpl = ApplicationController.render(
                  template: 'shared/_muuri_result',
                  locals: { result: results },
                  layout: false
                )
          TwitterChannel.broadcast_to @user, tpl
        rescue
          puts "Creation of result #{id} failed !"
        end
      else
        puts "Result already exists !"
      end

    end
  end

  private

  def renderer
    @renderer ||= Renderer.new.renderer
  end
end


