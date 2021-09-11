class ChangeMoveOrdersProvincesToReferences < ActiveRecord::Migration[6.1]
  def change
    remove_column :move_orders, :target_province, :integer
    add_reference :move_orders, :target_province, foreign_key: { to_table: :provinces }

    remove_column :move_orders, :current_province, :integer
    add_reference :move_orders, :current_province, foreign_key: { to_table: :provinces }
  end
end
