class AddJulianDateToQuality < ActiveRecord::Migration
  def change
    add_column :qualities, :julian_date, :string

  end
end
