class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :display_name

      t.timestamps
    end
  end
end
