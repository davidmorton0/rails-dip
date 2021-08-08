class AddCurrentMapToGame < ActiveRecord::Migration[6.1]
  def change
    add_column :games, :current_map, :string
  end
end
