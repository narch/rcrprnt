class StoreIdForTaxonomies < SpreeExtension::Migration[4.2]
  def self.up
    if table_exists?('spree_taxonomies')
      add_column :spree_taxonomies, :store_id, :integer
      add_index :spree_taxonomies, :store_id
    end
  end

  def self.down
    if table_exists?('spree_taxonomies')
      remove_column :spree_taxonomies, :store_id
    end
  end
end
