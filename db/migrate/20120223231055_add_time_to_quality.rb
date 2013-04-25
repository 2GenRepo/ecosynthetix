class AddTimeToQuality < ActiveRecord::Migration
  def change
    add_column :qualities, :time, :datetime

  end
end
