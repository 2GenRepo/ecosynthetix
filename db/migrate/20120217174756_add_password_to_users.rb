class AddPasswordToUsers < ActiveRecord::Migration
  def change
    add_column :users, :password, :encrypted_password

  end
end
