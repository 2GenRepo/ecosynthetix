class AddLastCorrectedViscosityValueToQualities < ActiveRecord::Migration
  def change
    add_column :qualities, :last_corrected_viscosity_value, :integer

  end
end
