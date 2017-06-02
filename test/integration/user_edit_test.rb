require 'test_helper'

class UserEditTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:one)
  end

  test 'unsuccessful edit' do
    log_in_as @user

    # Goto settings page.
    get edit_user_path(@user)
    assert_template 'users/edit'

    # Update user settings with incorrect data.
    patch user_path(@user), params: {
      user: {
        name: '',
        email: 'foo@invalid',
        password:              'foo',
        password_confirmation: 'bar'
      }
    }

    # Ensure we didn't leave the page.
    assert_template 'users/edit'

    assert flash.empty?

    # Ensure problems are listed.
    assert_select 'li', 'Name can\'t be blank'
    assert_select 'li', 'Email is invalid'
    assert_select 'li', 'Password confirmation doesn\'t match Password'
    assert_select 'li', 'Password is too short (minimum is 8 characters)'
  end

  test 'successful edit with friendly forwarding' do
    # Ensure no user is currently logged in.
    delete logout_path

    # Attempt to access settings page prior to log in.
    get edit_user_path(@user)

    # User should now get a 'Login required' message and redirected to login page.
    assert_redirected_to login_url

    # Log in.
    log_in_as @user

    # Ensure redirected to page user attempted to reach prior to 'Login required'.
    assert_redirected_to edit_user_url(@user)

    # Ensure the edit template was rendered.
    follow_redirect!
    assert_template 'users/edit'

    # Change user settings.
    name  = 'Foo Bar'
    email = 'foo@bar.com'
    patch user_path(@user), params: {
      user: {
        name:  name,
        email: email,
        password:              '',
        password_confirmation: ''
      }
    }

    # Ensure no errors and redirected to profile page.
    assert_not flash.empty?
    assert_redirected_to @user

    # Ensure new settings were pushed to the database.
    @user.reload
    assert_equal name,  @user.name
    assert_equal email, @user.email

    # Cleanup
    delete logout_path
  end
end
