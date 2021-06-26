# frozen_string_literal: true

class AddSupplyCenterToProvinces < ActiveRecord::Migration[6.1]
  def change
    add_column :provinces, :supply_center, :boolean
  end
end
