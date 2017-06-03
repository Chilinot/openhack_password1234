class AddImageColumnToJobs < ActiveRecord::Migration[5.0]
  def up
    add_attachment :jobs, :image
  end

  def down
    remove_attachment :jobs, :image
  end
end
