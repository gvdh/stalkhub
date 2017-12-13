class ResultsController < ApplicationController

  before_action :load_results

  def index
    if @loaded_provider.nil?
      return redirect_to new_provider_path(params[:provider])
    end

    if @loaded_provider.name == "facebook"
      if @loaded_provider.expires_at <= Time.now.to_i
        current_user.providers.destroy_all
        return redirect_to new_provider_path(params[:provider])
      end
    end
    unless @results.any?
      current_user.providers.destroy_all
      return redirect_to new_provider_path(params[:provider])
    end

    @type = params[:type]
    if params[:type] == 'photo'
      @results = @results.photos
    elsif params[:type] == 'text'
      @results = @results.texts
    elsif params[:type] == 'video'
      @results = @results.videos
    elsif params[:type] == 'page'
      @results = @results.pages
    end

    @order = params[:order]
    if params[:order] == 'reverse'
      @results = @results.order("created_at DESC")
    end

    # if params[:type] == 'to'
    #   @results = @client.get_all_tweets_from_user(params["twitter_username"])
    # else params[:type] == 'from'
    #   @results = @client.get_all_tweets_to_user(params["twitter_username"])
    # end

  end

  private

  def load_results
    @provider = params[:provider]
    @results = policy_scope(Result).select { |r| r.provider.name == @provider }
    @loaded_provider = Provider.where(name: params[:provider], user: current_user).last
  end
end
