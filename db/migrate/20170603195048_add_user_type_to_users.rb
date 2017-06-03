class AddUserTypeToUsers < ActiveRecord::Migration[5.0]
  def up
    add_column :users, :user_type, :integer, default: 0

    User.all.each do |user|
      if user.admin?
        user.user_type = 2
        user.save!
      end
    end

    remove_column :users, :admin
  end

  def down
    add_column :users, :admin, :boolean, default: false

    User.all.each do |user|
      if user.user_type == 2
        user.admin = true
      end
    end

    remove_column :users, :user_type
  end
end
