class AddColumnToPrices < ActiveRecord::Migration[6.0]
  def change
    add_column :spree_prices, :store_id, :integer
    add_index :spree_prices, :store_id
  end
end
