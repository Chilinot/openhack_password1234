class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user && @user.authenticate(params[:session][:password])

      log_in @user

      # Only remember the user if the checkbox is ticked.
      params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)

      flash[:success] = "Welcome back #{@user.name}!"
      redirect_back_or @user
    else
      flash.now[:danger] = 'Incorrect username and/or password!'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
