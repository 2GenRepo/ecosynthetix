class CreateLabMethods < ActiveRecord::Migration
  def change
    create_table :lab_methods do |t|
      t.string :display_name
      t.boolean :temperature
      t.boolean :solids
      t.boolean :moisture
      t.boolean :bulk_density

      t.timestamps
    end
  end
end
