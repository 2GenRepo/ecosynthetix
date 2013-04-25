class CreateQualityHistories < ActiveRecord::Migration
  def change
    create_table :quality_histories do |t|
      t.integer :quality_id
      t.integer :user_id

      t.timestamps
    end
  end
end
