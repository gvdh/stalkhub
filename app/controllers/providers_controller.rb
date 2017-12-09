class ProvidersController < ApplicationController

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
    provider = Provider.where(name: 'facebook', uid: hash[:uid]).first
    if provider
      FacebookJob.perform_now(provider)
      authorize provider
      provider.update(token: hash[:credentials][:token])
    else
      provider = Provider.create(
        name: params[:provider],
        uid: hash[:uid],
        token: hash[:credentials][:token],
        user: current_user
      )
      FacebookJob.perform_now(provider)
    end
  end

  def initializer
    @username = params[:username]
    authorize provider
    InstaJob.perform_now(@username)
    redirect_to results_path
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
