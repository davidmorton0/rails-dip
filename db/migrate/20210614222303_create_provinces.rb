# frozen_string_literal: true

class CreateProvinces < ActiveRecord::Migration[6.1]
  def change
    create_table :provinces do |t|
      t.string :name
      t.string :abbreviation

      t.timestamps
    end
  end
end
