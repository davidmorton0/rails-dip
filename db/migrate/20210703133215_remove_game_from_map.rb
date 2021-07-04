class RemoveGameFromMap < ActiveRecord::Migration[6.1]
  def change
    remove_reference :maps, :game
  end
end
