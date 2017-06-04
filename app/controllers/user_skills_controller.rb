class UserSkillsController < ApplicationController

  def create
    @userskill = UserSkill.new(userskill_params)

    if @userskill.save
      flash[:success] = 'The skill has been added to your profile.'
      redirect_to @userskill.user
    else
      # AW SHIT BOYE!
    end
  end

  private
    def userskill_params
      params.require(:userskill).permit(:user_id, :skill_id)
    end
end
