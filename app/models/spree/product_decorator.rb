module Spree
  Product.class_eval do
    has_paper_trail only: []
  end
end
