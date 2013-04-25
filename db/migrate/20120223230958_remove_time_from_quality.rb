class RemoveTimeFromQuality < ActiveRecord::Migration
  def up
    remove_column :qualities, :time
      end

  def down
    add_column :qualities, :time, :string
  end
end
