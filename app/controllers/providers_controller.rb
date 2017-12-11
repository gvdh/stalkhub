class ProvidersController < ApplicationController

  def create
    authorize Provider
    if params[:provider] == 'facebook'
      create_or_update_for_facebook(auth_hash)
    elsif params[:provider] == 'google'
      create_google(params)
    else
      flash[:alert] = 'Provider not handled'
      return redirect_to root_path
    end
    return redirect_to results_path(params[:provider])
  end

  def create_or_update_for_facebook(hash)
    provider = Provider.where(name: 'facebook', uid: hash[:uid]).first
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

  def create_google(params)
    user_ip = Geocoder.search("#{request.remote_ip}").first.city
    user_id = current_user.id
    full_name = params["full_name"]
    GoogleJob.perform_now(full_name, user_id, user_ip)
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
