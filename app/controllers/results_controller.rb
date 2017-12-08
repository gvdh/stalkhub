class ResultsController < ApplicationController

  def index
    provider = Provider.where(name: params[:provider], user: current_user).first

    @provider = params[:provider]
    @results = policy_scope(Result)
    #.where(provider: provider).order(created_at: :desc)
    if provider.nil? || @results.size < 1
      redirect_to new_provider_path(params[:provider])
    end

    # check_results_size(params)

    @type = params[:type]
    if params[:type] == 'photo'
      @results = @results.photos
      fail
    elsif params[:type] == 'text'
      @results = @results.texts
    elsif params[:type] == 'video'
      @results = @results.videos
    elsif params[:type] == 'page'
      @results = @results.pages
    end

    if params[:order] == 'reverse'
      @results = @results.order("created_at DESC")
    end
    @order = params[:order]
  end
end
