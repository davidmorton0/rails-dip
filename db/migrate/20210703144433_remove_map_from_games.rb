class RemoveMapFromGames < ActiveRecord::Migration[6.1]
  def change
    remove_reference :games, :map
  end
end
