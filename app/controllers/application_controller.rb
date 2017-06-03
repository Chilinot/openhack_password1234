class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  include SessionsHelper

  # ---- FILTERS

  # Confirms that the user is logged in.
  # If not, it redirects to the login page.
  def logged_in_user
    unless logged_in?
      # Store the location the user attempted to access
      # to enable redirection back to it after login.
      store_location
      flash[:danger] = 'Please log in.'
      redirect_to login_url
    end
  end

  # Confirms an admin user.
  # Redirects to root otherwise.
  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end

  # Confirms that the current user is the correct user.
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end
end
