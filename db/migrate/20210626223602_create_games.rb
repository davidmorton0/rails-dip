class CreateGames < ActiveRecord::Migration[6.1]
  def change
    create_table :games do |t|
      t.references :map
      t.integer :year
      t.string :season

      t.timestamps
    end
  end
end
