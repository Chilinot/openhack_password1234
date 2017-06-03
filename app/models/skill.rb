# == Schema Information
#
# Table name: skills
#
#  id          :integer          not null, primary key
#  title       :string
#  description :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Skill < ApplicationRecord
  validates :title, presence: true
  validates :description, presence: true

  has_many :job_skills
  has_many :jobs, through: :job_skills

  has_many :user_skills
  has_many :users, through: :user_skills
end
