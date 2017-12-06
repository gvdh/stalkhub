class ResultsController < ApplicationController

  def index
    provider = Provider.where(name: params[:provider], user: current_user).first
    if provider.nil?
      flash[:alert] = 'No provider'
      redirect_to new_provider_path(params[:provider])

    end

    @results = policy_scope(Result).where(provider: provider).order(created_at: :desc)
    if params[:type] == 'photo'
      @results = @results.photos
    elsif params[:type] == 'text'
      @results = @results.texts
    elsif params[:type] == 'video'
      @results = @results.videos
    end
  end

end
