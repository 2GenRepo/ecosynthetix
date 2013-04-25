class AddCoaPrintedToQualities < ActiveRecord::Migration
  def change
    add_column :qualities, :coa_printed, :boolean

  end
end
