module Spree
  module OrderDecorator
    def self.prepended(base)
      base.scope :by_store, -> (store) { where(store_id: store) }
    end

    def available_payment_methods
      @available_payment_methods ||= Spree::PaymentMethod.available(:front_end, store)
    end
  end
end

::Spree::Product.prepend ::Spree::ProductDecorator
