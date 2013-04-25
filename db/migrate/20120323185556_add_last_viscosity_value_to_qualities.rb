class AddLastViscosityValueToQualities < ActiveRecord::Migration
  def change
    add_column :qualities, :last_viscosity_value, :integer

  end
end
