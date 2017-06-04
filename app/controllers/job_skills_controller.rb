class JobSkillsController < ApplicationController
  def create
    @jobskill = JobSkill.new(jobskill_params)

    if @jobskill.save
      flash[:success] = 'The skill has been added to the listing.'
      redirect_to @jobskill.job
    else
      # AW SHIT BOYE!
    end
  end

  private
    def jobskill_params
      params.require(:jobskill).permit(:job_id, :skill_id, :level)
    end
end
