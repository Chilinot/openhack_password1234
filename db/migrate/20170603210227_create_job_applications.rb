class CreateJobApplications < ActiveRecord::Migration[5.0]
  def change
    create_table :job_applications do |t|
      t.belongs_to :user, index: true
      t.belongs_to :job,  index: true

      t.timestamps
    end
  end
end
