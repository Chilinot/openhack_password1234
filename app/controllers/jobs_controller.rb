class JobsController < ApplicationController

  # You have to be logged in for any action in this controller.
  before_action :logged_in_user

  before_action :user_filter, only: [:new, :create]

  def index
    @jobs = Job.paginate(page: params[:page])
  end

  def show
    @job = Job.find(params[:id])
  end

  def new
    @job = Job.new
  end

  def create
    @job = Job.new(job_params)
    if @job.save
      redirect_to @job
    else
      # Re-render new page to display errors.
      render 'new'
    end
  end

  private
    def job_params
      params.require(:job).permit(:title, :description, :image)
    end

    def user_filter
      redirect_to(root_url) unless current_user.admin? or current_user.employer?
    end

end
