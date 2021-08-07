class AddPositionToProvinces < ActiveRecord::Migration[6.1]
  def change
    add_column :provinces, :x_pos, :integer
    add_column :provinces, :y_pos, :integer
  end
end
