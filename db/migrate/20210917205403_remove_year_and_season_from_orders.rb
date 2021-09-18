class RemoveYearAndSeasonFromOrders < ActiveRecord::Migration[6.1]
  def change
    remove_column :orders, :year, :integer
    remove_column :orders, :season, :string
    remove_column :games, :year, :integer
    remove_column :games, :season, :string
  end
end
