class AddLastMoistureStateToQualities < ActiveRecord::Migration
  def change
    add_column :qualities, :last_moisture_state, :string

  end
end
