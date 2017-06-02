require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest

  def setup
    @non_admin = users(:one)
    @admin = users(:admin)
  end

  test "layout links when not logged in" do
    # Ensure no user is currently logged in
    delete logout_path

    get root_path

    # Ensure general links are listed.
    assert_select 'a[href=?]', root_path, count: 2
    assert_select 'a[href=?]', help_path
    assert_select 'a[href=?]', about_path
    assert_select 'a[href=?]', contact_path

    # Ensure admin links are not listed.
    assert_select 'a[href=?]', users_path, count: 0

    # Ensure user links are not listed.
    assert_select 'a[href=?]', jobs_path,  count: 0
  end

  test 'layout links as admin' do
    log_in_as @admin

    get root_path

    # Ensure general links are listed
    assert_select 'a[href=?]', root_path, count: 2
    assert_select 'a[href=?]', help_path
    assert_select 'a[href=?]', about_path
    assert_select 'a[href=?]', contact_path

    # Ensure admin links are listed
    assert_select 'a[href=?]', users_path

    # Ensure jobs links are listed.
    assert_select 'a[href=?]', jobs_path

    # Cleanup
    delete logout_path
  end

  test 'layout links as non admin' do
    log_in_as @non_admin

    get root_path

    # Ensure general links are listed
    assert_select 'a[href=?]', root_path, count: 2
    assert_select 'a[href=?]', help_path
    assert_select 'a[href=?]', about_path
    assert_select 'a[href=?]', contact_path

    # Ensure admin links are not listed
    assert_select 'a[href=?]', users_path, count: 0

    # Ensure jobs link are listed.
    assert_select 'a[href=?]', jobs_path

    # Cleanup
    delete logout_path
  end
end
