class AddLastColorLValueToQualities < ActiveRecord::Migration
  def change
    add_column :qualities, :last_color_l_value, :integer

  end
end
