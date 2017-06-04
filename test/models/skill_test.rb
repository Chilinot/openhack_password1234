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

require 'test_helper'

class SkillTest < ActiveSupport::TestCase
end
