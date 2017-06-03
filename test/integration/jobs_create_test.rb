require 'test_helper'

class JobsCreateTest < ActionDispatch::IntegrationTest

  def setup
    @non_admin = users(:one)
    @admin     = users(:admin)
  end

  test 'invalid job data' do
    # You have to be admin to access the job creation page.
    log_in_as @admin

    assert_no_difference 'Job.count' do
      post jobs_path, params: {
        job: {
          title: '',
          description: ''
        }
      }
    end

    assert_template 'jobs/new'

    assert_select 'li', 'Title can\'t be blank'
    assert_select 'li', 'Description can\'t be blank'

    delete logout_path
  end

end
