class JobsController < ApplicationController

  # You have to be logged in for any action in this controller.
  before_action :logged_in_user

  # Only admins are allowed the following actions:
  before_action :admin_user, only: [:new, :create]

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
      params.require(:job).permit(:title, :description)
    end

end
