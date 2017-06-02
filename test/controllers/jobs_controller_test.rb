require 'test_helper'

class JobsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:one)
  end

  test 'should redirect index when not logged in' do
    # Ensure no user is logged in.
    delete logout_path

    get jobs_path

    assert_not flash.empty?
    assert_redirected_to login_url
  end
end
