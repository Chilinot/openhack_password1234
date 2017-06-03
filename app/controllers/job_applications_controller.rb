class JobApplicationsController < ApplicationController

  def create
    @application = JobApplication.new(application_params)

    if @application.save
      flash[:success] = 'You have applied for the job.'
    else
      flash[:danger] = 'Something wen\'t wrong when applying for job!'
    end

    redirect_to jobs_path
  end

  private
    def application_params
      params.require(:job_application).permit(:user_id, :job_id)
    end
end
