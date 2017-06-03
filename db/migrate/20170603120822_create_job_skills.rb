class CreateJobSkills < ActiveRecord::Migration[5.0]
  def change
    create_table :job_skills do |t|
      t.belongs_to :job,   index: true
      t.belongs_to :skill, index: true

      t.timestamps
    end
  end
end
