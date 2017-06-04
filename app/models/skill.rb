# == Schema Information
#
# Table name: skills
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

class Skill < ApplicationRecord
  validates :title, presence: true
  validates :description, presence: true

  has_many :job_skills
  has_many :jobs, through: :job_skills

  has_many :user_skills
  has_many :users, through: :user_skills

  # Images
  has_attached_file :image,
                     styles: {
                       medium: "80x80>",
                       thumb: "30x30>"
                     },
                     default_url: "/images/:style/missing.png"

  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
end
