# frozen_string_literal: true

class AddSuccessToOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :success, :boolean
  end
end
