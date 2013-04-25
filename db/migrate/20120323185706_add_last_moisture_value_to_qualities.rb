class AddLastMoistureValueToQualities < ActiveRecord::Migration
  def change
    add_column :qualities, :last_moisture_value, :integer

  end
end
