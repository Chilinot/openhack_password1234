require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:one)
    @admin = users(:admin)
    @random = users(:user_12) # Some random user.
  end

  test 'index as non admin' do
    log_in_as @user

    # Get user list and ensure there are no delete links.
    get users_path
    assert_select 'a', text: 'delete', count: 0

    # Cleanup
    delete logout_path
  end

  test 'index as admin including pagination and delete links' do
    log_in_as @admin

    # Get user list
    get users_path
    assert_template 'users/index'

    # Ensure there is atleast one pagination menu
    assert_select 'div.pagination'

    # Ensure the entire first pagination page is listed.
    first_page_of_users = User.paginate(page: 1)
    first_page_of_users.each do |user|
      assert_select 'a[href=?]', user_path(user), text: user.name
      unless user == @admin
        assert_select 'a[href=?]', user_path(user), text: 'delete'
      end
    end

    # Ensure the admin can remove some random user.
    assert_difference 'User.count', -1 do
      delete user_path(@random)
    end

    # Cleanup
    delete logout_path
  end
end
