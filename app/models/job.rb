# == Schema Information
#
# Table name: jobs
#
#  id                 :integer          not null, primary key
#  title              :string
#  description        :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  image_file_name    :string
#  image_content_type :string
#  image_file_size    :integer
#  image_updated_at   :datetime
#

class Job < ApplicationRecord
  # Relations
  has_many :job_skills
  has_many :skills, through: :job_skills

  # General validations
  validates :title, presence: true
  validates :description, presence: true

  # Images
  has_attached_file :image,
                     styles: {
                       medium: "300x300>",
                       thumb: "100x100>"
                     },
                     default_url: "/images/:style/missing.png"

  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

  # Retrieves all jobs that require skills matching the user.
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
