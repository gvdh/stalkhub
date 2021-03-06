class ProvidersController < ApplicationController



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
    provider = Provider.create!(
        name: params[:provider],
        uid: hash[:uid],
        expires_at: hash[:credentials][:expires_at],
        token: hash[:credentials][:token],
        user: current_user
      )
    authorize provider
    FacebookJob.perform_later(provider.id)
  end

  def create_twitter(params)
    username = params["twitter_username"]
    user_id = current_user.id
    @provider = Provider.create!(
      name: "twitter",
      user: current_user,
      username: username
    )
    provider_id = @provider.id
    #TwitterJob.perform_later(username, user_id, provider_id)
  end

  def create_google(params)
    user_ip = Geocoder.search("#{request.remote_ip}").first.city
    country_code = Geocoder.search("#{request.remote_ip}").first.country_code
    user_id = current_user.id
    full_name = params["full_name"]
    provider = Provider.create!(
      name: "google",
      user: current_user
    )
    provider_id = provider.id
    GoogleJob.perform_later(full_name, user_id, user_ip, country_code, provider_id)
  end

  def create_instagram(params)
    skip_authorization
    provider = Provider.create(
        name: params[:provider],
        user: current_user
      )
    username = params[:username]
    user_id = current_user.id
    provider_id = provider.id
    InstaJob.perform_later(username, user_id, provider_id)
  end

  def new
    if params[:dr]
      a = current_user.providers.where(name: params[:provider])
      a.each do |providr|
       providr.destroy
      end
    end
    provider = Provider.new
    authorize provider
    @provider = params[:provider]
  end

  private

  def auth_hash
    request.env['omniauth.auth']
  end
end
