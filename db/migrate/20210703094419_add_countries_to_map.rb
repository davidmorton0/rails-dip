class AddCountriesToMap < ActiveRecord::Migration[6.1]
  def change
    add_column :maps, :countries, :string, array: true, default: []
  end
end
