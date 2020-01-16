class CreateProductsStores < SpreeExtension::Migration[4.2]
  def self.up
    create_table :spree_products_stores, :id => false do |t|
      t.references :product
      t.references :store
    end
    add_index :spree_products_stores, :product_id
    add_index :spree_products_stores, :store_id
  end

  def self.down
    drop_table :spree_products_stores
  end
end
