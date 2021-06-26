# frozen_string_literal: true

class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.string :order_type
      t.integer :target_province
      t.references :unit

      t.timestamps
    end
  end
end
