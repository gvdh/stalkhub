class ProvidersController < ApplicationController

  def create
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
      authorize provider
      provider.update(token: hash[:credentials][:token])
    else
      provider = Provider.create(
        name: params[:provider],
        uid: hash[:uid],
        token: hash[:credentials][:token],
        user: current_user
      )
    end
  end

  private

  def auth_hash
    request.env['omniauth.auth']
  end
end
