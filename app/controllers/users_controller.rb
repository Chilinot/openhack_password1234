class UsersController < ApplicationController

  # Only logged in users are allowed to access these actions:
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]

  # Users are only allowed to modify themselves.
  before_action :correct_user,   only: [:edit, :update]

  # Only admins are allowed the following actions:
  before_action :admin_user,     only: [:destroy, :index]

  # List all users.
  def index
    @users = User.paginate(page: params[:page])
  end

  # Profile page.
  def show
    @user = User.find(params[:id])
  end

  # Signup page.
  def new
    @user = User.new
  end

  # POST /signup
  # Recieves data from browser that contains signup data.
  def create
    # Create a new user using the received data.
    @user = User.new(user_params)

    # Can the user be saved to the database?
    # i.e. does the given parameters obey the model validations.
    if @user.save
      log_in @user
      remember @user
      flash[:success] = 'Welcome to Password!'
      redirect_to @user
    else
      # The user sent bad data.
      # Re-render signup page to display errors.
      render 'new'
    end
  end

  # Settings page.
  def edit
    @user = User.find(params[:id])
  end

  # Receives data from settings page.
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
end
