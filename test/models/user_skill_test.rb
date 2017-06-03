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

require 'test_helper'

class UserSkillTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
