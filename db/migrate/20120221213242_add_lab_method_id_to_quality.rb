class AddLabMethodIdToQuality < ActiveRecord::Migration
  def change
    add_column :qualities, :lab_method_id, :integer

  end
end
