# == Schema Information
#
# Table name: jobs
#
#  id          :integer          not null, primary key
#  title       :string
#  description :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Job < ApplicationRecord
  validates :title, presence: true
  validates :description, presence: true

  has_many :job_skills
  has_many :skills, through: :job_skills

  def self.jobs_matching_user_skills(user)
    jobs = []
    Job.all.each do |job|
      if (job.skills & user.skills) != []
        jobs.append job
      end
    end
    jobs
  end
end
