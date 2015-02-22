class AddActiveToUser < ActiveRecord::Migration

  def change


    add_column :users, :active, :boolean

    User.all.each do |user|
      user.update_attribute(:active, true)

    end
  end

end
