require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  test 'invalid signup information' do
    # Ensure signup can be rendered without errors.
    get signup_path

    # Assert controller doesn't accept incorrect values.
    assert_no_difference 'User.count' do
      post users_path, params: { user: { name: '', email: 'user@invalid', password: 'foo', password_confirmation: 'bar' } }
    end

    # Assert user never left signup page.
    assert_template 'users/new'

    # Ensure all error messages are listed.
    assert_select 'li', 'Name can\'t be blank'
    assert_select 'li', 'Email is invalid'
    assert_select 'li', 'Password confirmation doesn\'t match Password'
  end

  test 'correct signup information' do
    # Ensure signup can be rendered without errors.
    get signup_path

    # Assert user count is incremented by 1
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { name: 'asdf', email: 'foo@bar.com', password: 'foobar12', password_confirmation: 'foobar12' } }
    end

    # Ensure user was sent to their newly created page.
    assert_redirected_to user_url(User.last)
  end

  test 'already existing user failure' do
    # Ensure signup can be rendered
    get signup_path

    # User.count should not change if attempting to register with already stored email.
    assert_no_difference 'User.count' do
      post users_path, params: { user: { name: 'asdf', email: users(:one).email, password: 'asdfasdfasdf', password_confirmation: 'asdfasdfasdf' } }
    end

    # Ensure user never left signup page.
    assert_template 'users/new'

    # Ensure error message was shown.
    assert_select 'li', 'Email has already been taken'
  end
end
