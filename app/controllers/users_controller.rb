class UsersController < ApplicationController

  # Only logged in users are allowed to access these actions:
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]

  # Users are only allowed to modify themselves.
  before_action :correct_user,   only: [:edit, :update]

  # Only admins are allowed the following actions:
  before_action :admin_user,     only: [:destroy]

  def index
    @users = User.paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      remember @user
      flash[:success] = 'Welcome to the Sample App!'
      redirect_to @user
    else
      # Re-render signup page to display errors.
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = 'Profile updated'
      redirect_to @user
    else
      # Re-render edit to display errors.
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:succes] = 'User Deleted'
    redirect_to users_url
  end

  private
    # Allow only these params from the wild.
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    # Confirms that the user is logged in.
    def logged_in_user
      unless logged_in?
        # Store the location the user attempted to access
        # to enable redirection back to it after login.
        store_location
        flash[:danger] = 'Please log in.'
        redirect_to login_url
      end
    end

    # Confirms that the current user is the correct user.
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    # Confirms an admin user.
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
