class AddOrderStore < SpreeExtension::Migration[4.2]
  def self.up
    if table_exists?('spree_orders')
      add_column :spree_orders, :store_id, :integer unless column_exists?(:spree_orders, :store_id)
    end
  end

  def self.down
    if table_exists?('spree_orders')
      remove_column :spree_orders, :store_id
    end
  end
end
