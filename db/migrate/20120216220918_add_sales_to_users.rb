class AddSalesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :sales, :boolean

  end
end
