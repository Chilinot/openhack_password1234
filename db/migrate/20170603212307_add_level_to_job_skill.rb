class AddLevelToJobSkill < ActiveRecord::Migration[5.0]
  def change
    add_column :job_skills, :level, :integer, default: 0
  end
end
