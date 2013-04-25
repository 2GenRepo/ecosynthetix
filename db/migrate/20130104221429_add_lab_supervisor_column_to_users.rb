class AddLabSupervisorColumnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :labSupervisor, :boolean

  end
end
