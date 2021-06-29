class RemoveGameAndUnitFromOrder < ActiveRecord::Migration[6.1]
  def change
    remove_column :orders, :game
    remove_column :orders, :unit_id
  end
end
