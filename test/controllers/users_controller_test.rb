require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user       = users(:one)
    @other_user = users(:two)
  end

  test "should get new" do
    get signup_path
    assert_response :success
  end

  test "should redirect edit when not logged in" do
    # Ensure no user is logged in.
    delete logout_path

    get edit_user_path(@user)

    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect update when not logged in" do
    # Ensure no user is logged in.
    delete logout_path

    patch user_path(@user), params: {
      user: {
        name: @user.name,
        email: @user.email
      }
    }

    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect edit when logged in as wrong user" do
    # Log in
    log_in_as @user

    # Attempt to get settings page of other user.
    get edit_user_path(@other_user)

    # Assert redirection back to home.
    assert flash[:danger].nil?
    assert_redirected_to root_url

    # Log out, because the tests don't run in isolation it would seem.
    delete logout_path
  end

  test "should redirect update when logged in as wrong user" do
    # Log in
    log_in_as @user

    # Attempt to modify other user.
    patch user_path(@other_user), params: {
      user: {
        name: @other_user.name,
        email: @other_user.email
      }
    }

    # Assert redirection back to home.
    assert flash[:danger].nil?
    assert_redirected_to root_url

    # Log out, because the tests don't run in isolation it would seem.
    delete logout_path
  end

  test 'should redirect index when not logged in' do
    # Ensure no user is currently logged in.
    delete logout_path

    # Attempt to access user-list without loggin in.
    get users_path

    # Ensure redirected to login page.
    assert_redirected_to login_url
  end

  test 'should not allow the admin attribute to be edited via the web' do
    # Log in and ensure the user is not an admin.
    log_in_as @other_user
    assert_not @other_user.admin?

    # Attempt to change the user to an admin through and UPDATE request.
    patch user_path(@other_user), params: {
      user: {
        password: 'password72',
        password_confirmation: 'password72',
        admin: true
      }
    }

    # Ensure this didn't modify the user.
    assert_not @other_user.reload.admin?

    # Cleanup
    delete logout_path
  end

  test 'should redirect destroy when not logged in' do
    # Ensure no user is currently logged in.
    delete logout_path

    assert_no_difference 'User.count' do
      delete user_path(@user)
    end
    assert_redirected_to login_url
  end

  test 'should redirect destroy when logged in as non-admin' do
    # Ensure no use is currently logged in.
    delete logout_path

    # Log in as non-admin user.
    log_in_as @user

    # Attempt to delete other user.
    assert_no_difference 'User.count' do
      delete user_path(@other_user)
    end
    assert_redirected_to root_url
  end
end
