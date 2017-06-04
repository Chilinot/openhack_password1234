class AddImagesToSkills < ActiveRecord::Migration[5.0]
  def up
    add_attachment :skills, :image
  end

  def down
    remove_attachment :skills, :image
  end
end
