class AddSupplyToPlayers < ActiveRecord::Migration[6.1]
  def change
    add_column :players, :supply, :integer
  end
end
