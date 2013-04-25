class RemoveEmailAddressFromUsers < ActiveRecord::Migration
  def up
remove_column :users, :email_address

  end

  def down
  end
end
