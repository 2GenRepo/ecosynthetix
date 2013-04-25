class AddLastDispositionStateToQualities < ActiveRecord::Migration
  def change
    add_column :qualities, :last_disposition_state, :string

  end
end
