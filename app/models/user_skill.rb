# == Schema Information
#
# Table name: user_skills
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  skill_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  level      :integer          default(0)
#

class UserSkill < ApplicationRecord
  belongs_to :user
  belongs_to :skill

  def self.skill_level(user, skill)
    UserSkill.where(user: user.id, skill: skill.id)[0].level
  end
end
