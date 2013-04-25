class AddSkidToQuality < ActiveRecord::Migration
  def change
    add_column :qualities, :skid, :string

  end
end
