class CreatePlayers < ActiveRecord::Migration[6.1]
  def change
    create_table :players do |t|
      t.references :game, null: false, foreign_key: true
      t.string :country

      t.timestamps
    end
  end
end
