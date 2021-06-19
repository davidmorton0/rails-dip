class AddProvinceTypeToProvince < ActiveRecord::Migration[6.1]
  def change
    add_column :provinces, :province_type, :string
  end
end
