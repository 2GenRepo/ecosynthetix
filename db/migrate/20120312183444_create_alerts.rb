class CreateAlerts < ActiveRecord::Migration
  def change
    create_table :alerts do |t|
      t.string :display_name
      t.string :alert_type
      t.string :who_to_alert

      t.timestamps
    end
  end
end
