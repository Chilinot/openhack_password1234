class SessionsController < ApplicationController
  # Login page
  def new
  end

  # POST /login
  # Receives email (username) and password from browser.
  def create
    # Locate user in database using given email.
    @user = User.find_by(email: params[:session][:email].downcase)

    # Did the user enter the correct password?
    if @user && @user.authenticate(params[:session][:password])

      log_in @user

      # Only remember the user if the checkbox is ticked.
      params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)

      # Show success message, and send user to their profile page.
      flash[:success] = "Welcome back #{@user.name}!"
      redirect_back_or @user
    else
      flash.now[:danger] = 'Incorrect username and/or password!'
      render 'new'
    end
  end

  # Called when user presses the logout button.
  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
