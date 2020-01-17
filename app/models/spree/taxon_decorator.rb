module Spree
  module TaxonDecorator
    module ClassMethods
      def find_by_store_id_and_permalink!(store_id, permalink)
        by_store(store_id).where(permalink: permalink).first!
      end
    end

    def self.prepended(base)
      base.singleton_class.prepend ClassMethods

      base.scope :by_store, -> (store) { joins(:taxonomy).merge(Spree::Taxonomy.by_store(store)) }
    end
  end
end

::Spree::Taxon.prepend ::Spree::TaxonDecorator
