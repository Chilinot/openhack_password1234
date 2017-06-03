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
end
