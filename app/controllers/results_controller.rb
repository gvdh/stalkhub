class ResultsController < ApplicationController

  before_action :load_results

  def index
    #.where(provider: provider).order(created_at: :desc)
    if @loaded_provider.nil?
      return redirect_to new_provider_path(params[:provider])
    end

    if @loaded_provider.expires_at >= Time.now.to_i
      return redirect_to new_provider_path(params[:provider])
    end

    if @results.size < 1 && params[:provider] == "facebook"
      FacebookJob.perform_later(provider.id)
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
  end

  private

  def load_results
    @loaded_provider = Provider.where(name: params[:provider], user: current_user).first
    @provider = params[:provider]
    @results = policy_scope(Result)
  end
end
