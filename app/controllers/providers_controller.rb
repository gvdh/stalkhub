class ProvidersController < ApplicationController

#  before_action :facebook_token_expired?

  def create
    authorize Provider
    if params[:provider] == 'facebook'
      create_or_update_for_facebook(auth_hash)
    elsif params[:provider] == 'twitter'
      create_twitter(params)
    elsif params[:provider] == 'google'
      create_google(params)
    else
      flash[:alert] = 'Provider not handled'
      return redirect_to root_path
    end
    return redirect_to results_path(params[:provider])
  end


  def create_or_update_for_facebook(hash)
    provider = Provider.create(
        name: params[:provider],
        uid: hash[:uid],
        expires_at: hash[:credentials][:expires_at],
        token: hash[:credentials][:token],
        user: current_user
      )
    if provider && !(provider.expires_at <= Time.now.to_i)
      provider.update(token: hash[:credentials][:token])
      authorize provider
      begin
        FacebookJob.perform_now(provider.id)
      rescue
        return redirect_to new_provider_path(params[:provider])
        flash[:alert] = 'Something went wrong, please try again'
      end
    end
  end


  def create_twitter(params)
    user = User.find(current_user.id)
    TwitterJob.perform_now(params, user)
  end

  def create_google(params)
    user_ip = Geocoder.search("#{request.remote_ip}").first.city
    user_id = current_user.id
    full_name = params["full_name"]
    GoogleJob.perform_now(full_name, user_id, user_ip)
  end

  def initializer
    skip_authorization
    provider = Provider.create(
        name: params[:provider],
        user: current_user,
        expires_at: 999999999
      )
    @username = params[:username]
    InstaJob.perform_later(@username, current_user)
    redirect_to results_path(params[:provider])
  end

  def new
    # Ugly way to authorize method (instanciate an unused Provider)
    provider = Provider.new
    authorize provider
    @provider = params[:provider]
  end

  private

  def auth_hash
    request.env['omniauth.auth']
  end
end
