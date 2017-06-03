require 'test_helper'

class JobsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @non_admin = users(:one)
    @admin     = users(:admin)
  end

  test 'should redirect index when not logged in' do
    # Ensure no user is logged in.
    delete logout_path

    get jobs_path

    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test 'should redirect new when not logged in' do
    delete logout_path

    get new_job_path

    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test 'should redirect new when not logged in as admin' do
    log_in_as @non_admin

    get new_job_path

    assert_not flash.empty?
    assert_redirected_to root_url

    delete logout_path
  end

  test 'should allow admins to access new page' do
    log_in_as @admin

    get new_job_path

    assert_template 'jobs/new'

    delete logout_path
  end

  test 'should not allow non admins to create new jobs' do
    log_in_as @non_admin

    assert_no_difference 'Job.count' do
      post jobs_path, params: {
        job: {
          title: 'asdf',
          description: 'laskfdj aowiro2i3j o2i3j4 2l3kjwle r'
        }
      }
    end

    delete logout_path
  end

  test 'should allow admins to create new jobs' do
    log_in_as @admin

    assert_difference 'Job.count', 1 do
      post jobs_path, params: {
        job: {
          title: 'lkakjsdf;adsf',
          description: 'laksjdfoas idfo isjdfo iajdsif jsfd'
        }
      }
    end

    delete logout_path
  end

end
