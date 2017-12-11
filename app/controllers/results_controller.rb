class ResultsController < ApplicationController

  def index
    provider = Provider.where(name: params[:provider], user: current_user).last

    @provider = params[:provider]
    @results = policy_scope(Result)

    #.where(provider: provider).order(created_at: :desc)
    if provider.nil?
      return redirect_to new_provider_path(params[:provider])
    end

    # if provider.expires_at >= Time.now.to_i
    #   return redirect_to new_provider_path(params[:provider])
    # end


    # check_results_size(params)
    if @results.size < 1
      provider_id = provider.id
      FacebookJob.perform_later(provider_id)
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

end
