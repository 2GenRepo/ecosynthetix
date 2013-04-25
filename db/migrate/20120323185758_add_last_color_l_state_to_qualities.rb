class AddLastColorLStateToQualities < ActiveRecord::Migration
  def change
    add_column :qualities, :last_color_l_state, :string

  end
end
