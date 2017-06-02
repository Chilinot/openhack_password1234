module SessionsHelper

  # Logs in the given user.
  def log_in(user)
    session[:user_id] = user.id
    @current_user = user
  end

  # Logs out any current user.
  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end

  # Checks if a user is logged in.
  def logged_in?
    !current_user.nil?
  end

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

  # Remembers a user in a persistent session.
  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent.signed[:remember_token] = user.remember_token
  end

  # Forgets a persistent session.
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  # Gets the currently logged in user.
  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies.signed[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  # Returns true if the given user is the current user.
  def current_user?(user)
    user == current_user
  end

  # Redirects to stored location (or the default)
  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  # Stores the URL currently trying to be accessed.
  def store_location
    # Store the url if the request is a GET.
    session[:forwarding_url] = request.original_url if request.get?
  end
end
