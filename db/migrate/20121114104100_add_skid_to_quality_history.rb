class AddSkidToQualityHistory < ActiveRecord::Migration
  def change
    add_column :quality_histories, :skid, :string

  end
end
