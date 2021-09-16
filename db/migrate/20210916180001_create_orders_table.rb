class CreateOrdersTable < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.string :type
      t.string :unit_type
      t.integer :year
      t.string :season
      t.boolean :success
      t.string :failure_reason
      t.references :player, null: false, foreign_key: true
      t.references :origin_province, null: true, foreign_key: { to_table: :provinces }
      t.references :target_province, null: true, foreign_key: { to_table: :provinces }

      t.timestamps
    end
  end
end
