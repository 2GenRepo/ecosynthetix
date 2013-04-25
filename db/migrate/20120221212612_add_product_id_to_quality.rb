class AddProductIdToQuality < ActiveRecord::Migration
  def change
    add_column :qualities, :product_id, :integer

  end
end
