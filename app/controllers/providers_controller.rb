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
    elsif params[:provider] == 'instagram'
      create_instagram(params)
    else
      flash[:alert] = 'Provider not handled'
      return redirect_to root_path
    end
    return redirect_to results_path(params[:provider])
  end


  def create_or_update_for_facebook(hash)
    provider = Provider.where(name: "facebook", user: current_user).last
    if provider && !(provider.expires_at <= Time.now.to_i)
      provider.update(token: hash[:credentials][:token])
      authorize provider
    else
      provider = Provider.create!(
        name: params[:provider],
        uid: hash[:uid],
        expires_at: hash[:credentials][:expires_at],
        token: hash[:credentials][:token],
        user: current_user
      )
      authorize provider
    end
    FacebookJob.perform_later(provider)
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

  def create_instagram(params)
    skip_authorization
    provider = Provider.create(
        name: params[:provider],
        user: current_user
      )
    @username = params[:username]
    InstaJob.perform_now(@username, current_user, provider)
  end

  def new
    provider = Provider.new
    authorize provider
    @provider = params[:provider]
  end

  private

  def auth_hash
    request.env['omniauth.auth']
  end
end
