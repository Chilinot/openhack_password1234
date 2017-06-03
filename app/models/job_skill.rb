# == Schema Information
#
# Table name: job_skills
#
#  id         :integer          not null, primary key
#  job_id     :integer
#  skill_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  level      :integer          default(0)
#

class JobSkill < ApplicationRecord
  belongs_to :job
  belongs_to :skill

  def self.skill_level(job, skill)
    JobSkill.where(job: job.id, skill: skill.id).level
  end
end
