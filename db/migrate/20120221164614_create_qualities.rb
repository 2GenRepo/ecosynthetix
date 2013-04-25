class CreateQualities < ActiveRecord::Migration
  def change
    create_table :qualities do |t|
      t.integer :user_id
      t.datetime :date
      t.string :lot
      t.decimal :viscosity
      t.decimal :solids
      t.decimal :moisture
      t.decimal :bulk_density
      t.decimal :color_l
      t.decimal :color_a
      t.decimal :color_b
      t.string :starch_lot

      t.timestamps
    end
  end
end
