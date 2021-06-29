class AddGameToUnits < ActiveRecord::Migration[6.1]
  def change
    add_reference :units, :game, index: true
  end
end
