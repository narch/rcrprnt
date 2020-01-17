module Spree
  module TrackerDecorator
    module ClassMethods
      def current(engine = Spree::Tracker::TRACKING_ENGINES, domain)
        Spree::Tracker.where(engine: engine).active.joins(:store).where("spree_stores.url LIKE ?", "%#{domain}%").first
      end
    end

    def self.prepended(base)
      base.singleton_class.prepend ClassMethods

      base.belongs_to :store
    end
  end
end

::Spree::Tracker.prepend ::Spree::TrackerDecorator
