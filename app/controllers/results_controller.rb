class ResultsController < ApplicationController

  def index
    provider = Provider.where(name: params[:provider], user: current_user).first

    @provider = params[:provider]
    @results = policy_scope(Result)
    #.where(provider: provider).order(created_at: :desc)
    if provider.nil? || @results.size < 1
      flash[:alert] = 'No provider'
      redirect_to new_provider_path(params[:provider])
    end

    # check_results_size(params)

    @type = params[:type]
    if params[:type] == 'photo'
      @results = @results.photos
    elsif params[:type] == 'text'
      @results = @results.texts
    elsif params[:type] == 'video'
      @results = @results.videos
    end
  end

  # def check_results_size(params)
  #   if @results.size == 0
  #     redirect_to new_provider_path(params[:provider])
  #   end
  # end

end
