class AddLastBulkDensityStateToQualities < ActiveRecord::Migration
  def change
    add_column :qualities, :last_bulk_density_state, :string

  end
end
