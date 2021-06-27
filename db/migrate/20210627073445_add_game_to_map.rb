class AddGameToMap < ActiveRecord::Migration[6.1]
  def change
    add_reference :maps, :game, foreign_key: true
  end
end
