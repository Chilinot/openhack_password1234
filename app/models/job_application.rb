# == Schema Information
#
# Table name: job_applications
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  job_id     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class JobApplication < ApplicationRecord
  belongs_to :job
  belongs_to :user
end
