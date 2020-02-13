class AddVendorTable < ActiveRecord::Migration[6.0]
  def change
    create_table :spree_vendors do |t|
      t.string :name
      t.datetime :deleted_at
      t.timestamps
    end
    add_column :spree_variants, :vendor_id, :integer
    add_column :spree_variants, :vendor_price, :decimal, precision: 8, scale: 2
    add_index :spree_variants, :vendor_id
    add_index :spree_vendors, :deleted_at
  end
end
