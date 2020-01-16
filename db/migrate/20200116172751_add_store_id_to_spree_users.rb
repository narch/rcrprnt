class AddStoreIdToSpreeUsers < ActiveRecord::Migration[6.0]
  def change
    change_table :spree_users do |t|
      t.references :spree_store
    end
  end
end
