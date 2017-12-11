class ProvidersController < ApplicationController

#  before_action :facebook_token_expired?

  def create
    authorize Provider
    if params[:provider] == 'facebook'
      create_or_update_for_facebook(auth_hash)
    # add new providers here (elsif)
    else
      flash[:alert] = 'Provider not handled'
      return redirect_to root_path
    end
    redirect_to results_path(params[:provider])
  end


  def create_or_update_for_facebook(hash)
    provider = Provider.where(name: 'facebook', user: current_user).last
    if provider && provider.expires_at <= Time.now.to_i
      provider.update(token: hash[:credentials][:token])
      authorize provider
      begin
        FacebookJob.perform_now(provider.id)
      rescue
        return redirect_to new_provider_path(params[:provider])
        flash[:alert] = 'Something went wrong, please try again'
      end
    else
      provider = Provider.create(
        name: params[:provider],
        uid: hash[:uid],
        expires_at: hash[:credentials][:expires_at],
        token: hash[:credentials][:token],
        user: current_user
      )
    end
  end

  def create_for_instagram
    skip_authorization
    provider = Provider.create(
        name: params[:provider],
        user: current_user
      )
    @username = params[:username]
    InstaJob.perform_now(@username, current_user)
    redirect_to results_path(params[:provider])
  end


  def new
    # Ugly way to authorize method (instanciate an unused Provider)
    provider = Provider.new
    authorize provider

    @provider = params[:provider]
  end

  private

  # def facebook_token_expired?
  #   if provider.expires_at >= Time.now.to_i
  #   end
  # end

  def auth_hash
    request.env['omniauth.auth']
  end
end
