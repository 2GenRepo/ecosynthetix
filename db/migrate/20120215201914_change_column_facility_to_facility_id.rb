class ChangeColumnFacilityToFacilityId < ActiveRecord::Migration
  def up
    rename_column :users, :facility, :facility_id
  end

  def down
  end
end
