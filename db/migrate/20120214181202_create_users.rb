class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :password
      t.string :first_name
      t.string :last_name
      t.integer :facility
      t.string :email_address
      t.string :roles
      t.string :options

      t.timestamps
    end
  end
end
