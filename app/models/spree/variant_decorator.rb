module Spree
  module VariantDecorator
    def self.prepended(base)
      base.before_save do
        self.track_inventory = false
      end
    end
  end
end

::Spree::Variant.prepend ::Spree::VariantDecorator
