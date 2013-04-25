class AddTankToQuality < ActiveRecord::Migration
  def change
    add_column :qualities, :tank, :integer

  end
end
