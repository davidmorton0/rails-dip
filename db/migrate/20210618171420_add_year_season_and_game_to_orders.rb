# frozen_string_literal: true

class AddYearSeasonAndGameToOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :year, :integer
    add_column :orders, :season, :string
    add_column :orders, :game, :integer
  end
end
