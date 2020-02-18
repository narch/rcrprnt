module Spree
  module ProductDecorator
    def self.prepended(base)
      base.has_and_belongs_to_many :stores, join_table: 'spree_products_stores'
      base.scope :by_store, -> (store) { joins(:stores).where(spree_products_stores: { store_id: store }) }

      base.has_many :option_values,
      through: :variants

      base.has_many :option_value_variants,
      through: :variants

      def variant_from_options(ids_array)
        self.option_value_variants.joins(:option_value).where(option_value_id: ids_array).group(:variant_id).having("count(*) = #{option_types.count}").first
      end

      def available_options(option_values = nil, variants = nil)
        if option_values
          ids = option_values.map(&:to_i)
          variant_ids = !variants.blank? ? variants : self.option_value_variants.where(option_value_id: ids).group(:variant_id).having("count(variant_id) = #{ids.count}").pluck(:variant_id)
          return Spree::OptionValue.joins(:option_value_variants).where("variant_id IN (?)", variant_ids).group(:name, :option_type_id).order('spree_option_values.position, spree_option_values.id')
        else
          return self.option_values.order('spree_option_values.position, spree_option_values.id').group(:name, :option_type_id)
        end
      end

      def options_hash(option_values = nil, variants = nil)
        h = {}
        position = 0
        for ot in self.option_types
          h[ot.id] = {presentation: ot.presentation, values: [], position:  position += 1}
        end
        for option in self.available_options(option_values, variants)
          h[option.option_type_id][:values] << {id: option.id, presentation: option.presentation}
        end
        return h
      end
    end
  end
end

::Spree::Product.prepend ::Spree::ProductDecorator
