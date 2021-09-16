class DropMoveOrdersAndBuildOrdersTables < ActiveRecord::Migration[6.1]
  def change
    drop_table :move_orders
    drop_table :build_orders
  end
end
