class CreateBuildOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :build_orders do |t|
      t.references :province, null: false, foreign_key: true
      t.string :unit_type
      t.references :player, null: false, foreign_key: true
      t.integer :year
      t.string :season
      t.boolean :sucess
      t.string :fail_reason

      t.timestamps
    end
  end
end
