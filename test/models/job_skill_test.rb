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

require 'test_helper'

class JobSkillTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
