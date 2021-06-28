class AddPlayerToOrders < ActiveRecord::Migration[6.1]
  def change
    add_reference :orders, :player, foreign_key: true
  end
end
