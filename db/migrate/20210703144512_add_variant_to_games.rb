class AddVariantToGames < ActiveRecord::Migration[6.1]
  def change
    add_reference :games, :variant, null: false, foreign_key: true
  end
end
