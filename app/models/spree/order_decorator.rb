module Spree
  Order.class_eval do
    has_many :order_versions
  end
end
