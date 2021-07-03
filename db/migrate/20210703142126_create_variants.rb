class CreateVariants < ActiveRecord::Migration[6.1]
  def change
    create_table :variants do |t|
      t.string :name
      t.string :countries, :string, array: true, default: []
      t.integer :starting_year
      t.string :starting_season
      t.references :map, null: false, foreign_key: true

      t.timestamps
    end
  end
end
