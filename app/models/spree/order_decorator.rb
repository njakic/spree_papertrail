module Spree
  Order.class_eval do
    has_many :order_versions

    after_save :make_version

    private
      def make_version
        Spree::OrderVersion.make_version(order: self)
      end
  end
end
