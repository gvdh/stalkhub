class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    # FB.getLoginStatus
    # fail
  end

  private

  # FB.getLoginStatus(function(response) {
  #     statusChangeCallback(response);
  # });
end
