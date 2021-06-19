class AddFailReasonToOrder < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :fail_reason, :string
  end
end
