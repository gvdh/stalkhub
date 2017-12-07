class PagesController < ApplicationController

  def home
    if current_user.nil?
      redirect_to new_user_registration_path
    else
      redirect_to results_path('facebook')
    end
  end

  private

  # FB.getLoginStatus(function(response) {
  #     statusChangeCallback(response);
  # });
end
