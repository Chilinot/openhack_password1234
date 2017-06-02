require 'test_helper'

class JobsIndexTest < ActionDispatch::IntegrationTest

  def setup
    # Regular user
    @user = users(:one)
  end

  test 'index with pagination and logged in' do
    log_in_as @user

    # Retrieve job list.
    get jobs_path
    assert_template 'jobs/index'

    # Assert the page is paginated.
    assert_select 'div.pagination'

    first_page_of_jobs = Job.paginate(page: 1)
    first_page_of_jobs.each do |job|
      # Assert there is a link to each job.
      assert_select 'a[href=?]', job_path(job)
      # Assert description is truncated to 250 characters.
      assert_select 'p.list-group-item-text',
        text: 'Id non repudiandae nostrum error sint culpa. Ipsam tempora incidunt aut. Sequi consequatur earum ut. Fuga et in sint illum molestiae iste temporibus. Sit qui accusantium a sed.  Magni rerum quod provident consequatur corrupti. Deleniti et perferen...'
    end

    # Cleanup
    delete logout_path
  end
end
