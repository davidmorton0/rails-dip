class AddTurnToOrders < ActiveRecord::Migration[6.1]
  def change
    add_reference :orders, :turn, null: false, foreign_key: true
  end
end
