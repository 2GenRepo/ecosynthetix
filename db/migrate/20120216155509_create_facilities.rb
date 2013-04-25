class CreateFacilities < ActiveRecord::Migration
  def change
    create_table :facilities do |t|
      t.string :display_name
      t.string :city

      t.timestamps
    end
  end
end
