class AddTemperatureToQuality < ActiveRecord::Migration
  def change
    add_column :qualities, :temperature, :decimal

  end
end
