# frozen_string_literal: true

class AddMapToProvinces < ActiveRecord::Migration[6.1]
  def change
    add_reference :provinces, :map, null: false, foreign_key: true
  end
end
