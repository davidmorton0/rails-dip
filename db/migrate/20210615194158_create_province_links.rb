class CreateProvinceLinks < ActiveRecord::Migration[6.1]
  def change
    create_table :province_links do |t|
      t.integer :province_id
      t.integer :links_to

      t.timestamps
    end
  end
end
