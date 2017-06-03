class SkillsController < ApplicationController

  # You have to be logged in to access skills.
  before_action :logged_in_user

  # Only admins are allowed these actions.
  before_action :admin_user, only: [:new, :create, :update, :destroy, :edit]

  def index
    @skills = Skill.paginate(page: params[:page])
  end

  def show
    @skill = Skill.find(params[:id])
  end

  def new
    @skill = Skill.new
  end

  def create
    @skill = Skill.new(skill_params)
    if @skill.save
      redirect_to skills_path
    else
      render 'new'
    end
  end

  private
    def skill_params
      params.require(:skill).permit(:title, :description)
    end
end
