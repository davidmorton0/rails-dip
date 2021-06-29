class AddCurrentProvinceToOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :current_province, :integer
  end
end
