class AddLastBulkDensityValueToQualities < ActiveRecord::Migration
  def change
    add_column :qualities, :last_bulk_density_value, :integer

  end
end
