class AddDigitalColumnToVariants < ActiveRecord::Migration[6.0]
  def change
    add_column :spree_variants, :digital_print, :boolean, default: 0
    add_index :spree_variants, :digital_print
  end
end
