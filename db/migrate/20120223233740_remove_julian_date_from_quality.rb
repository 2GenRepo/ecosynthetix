class RemoveJulianDateFromQuality < ActiveRecord::Migration
  def up
    remove_column :qualities, :julian_date
      end

  def down
    add_column :qualities, :julian_date, :string
  end
end
