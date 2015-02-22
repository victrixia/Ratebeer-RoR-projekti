class AddAdminToUser < ActiveRecord::Migration
  def change
    add_column :users, :admin, :boolean

    User.all.each do |user|
      user.update_attribute(:admin,false)

    end
  end
end
