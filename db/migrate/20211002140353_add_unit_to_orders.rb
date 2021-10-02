class AddUnitToOrders < ActiveRecord::Migration[6.1]
  def change
    add_reference :orders, :unit, null: true, foreign_key: true
  end
end
