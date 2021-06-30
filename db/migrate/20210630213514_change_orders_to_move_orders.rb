class ChangeOrdersToMoveOrders < ActiveRecord::Migration[6.1]
  def change
    rename_table :orders, :move_orders
  end
end
