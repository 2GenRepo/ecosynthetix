class AddActionTypeToQualityHistory < ActiveRecord::Migration
  def change
    add_column :quality_histories, :action_type, :string

  end
end
