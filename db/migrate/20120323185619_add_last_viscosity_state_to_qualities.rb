class AddLastViscosityStateToQualities < ActiveRecord::Migration
  def change
    add_column :qualities, :last_viscosity_state, :string

  end
end
