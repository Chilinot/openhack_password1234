require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:one)
  end

  test 'login with invalid information' do
    # Goto login page.
    get login_path
    assert_template 'sessions/new'

    # Attempt to login with incorrect data.
    post login_path, params: { session: { email: '', password: '' } }

    # Ensure that we didn't leave the page.
    assert_template 'sessions/new'

    # Ensure the flash contains some message.
    assert_not flash.empty?

    # Goto homepage and ensure flash is now empty.
    get root_path
    assert flash.empty?
  end

  test 'login with valid information followed by logout' do
    # Go to homepage
    get root_path

    # Ensure there is a login link (so we can be sure it was removed after log in).
    #assert_select 'a[href=?]', login_path

    # Goto login page
    get login_path

    # Log in.
    post login_path, params: { session: { email: @user.email, password: 'password72' } }
    assert is_logged_in?

    # Ensure redirection to profile page.
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'

    # Ensure login link is removed and replaced with profile and logout links.
    assert_select 'a[href=?]', login_path, count: 0
    assert_select 'a[href=?]', logout_path
    assert_select 'a[href=?]', user_path(@user)

    # Log out.
    delete logout_path
    assert_not is_logged_in?

    # Ensure redirection to homepage.
    assert_redirected_to root_url

    # Simulate user clicking logout again, in a separate window (this should not cause an exception).
    delete logout_path

    # Ensure login link is back and logout and profile links are gone.
    follow_redirect!
    assert_select 'a[href=?]', login_path
    assert_select 'a[href=?]', logout_path,      count: 0
    assert_select 'a[href=?]', user_path(@user), count: 0
  end

  test 'login with remembering' do
    log_in_as @user, remember_me: '1'

    # Ensure there is now a token stored in the cookie jar.
    assert_not_empty cookies['remember_token']

    # The CookieJar doesn't support signed cookies in Rails 5.
    # Thusly, we have to manually sign the value we want to check.
    my_cookies = ActionDispatch::Request.new(Rails.application.env_config).cookie_jar
    my_cookies.signed[:token] = assigns[:user].remember_token

    # Ensure the manually signed user.remember_token matches the one stored in the signed cookie set by the controller.
    assert_equal cookies['remember_token'], my_cookies[:token]
  end

  test 'login without remembering' do
    # Log in with cookie to store it.
    log_in_as @user, remember_me: '1'

    # Log in again without remember_me to ensure the cookie is deleted.
    log_in_as @user, remember_me: '0'

    assert_empty cookies['remember_token']
  end
end
