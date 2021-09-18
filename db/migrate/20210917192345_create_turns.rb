class CreateTurns < ActiveRecord::Migration[6.1]
  def change
    create_table :turns do |t|
      t.integer :year
      t.string :season
      t.references :game, null: false, foreign_key: true

      t.timestamps
    end
  end
end
