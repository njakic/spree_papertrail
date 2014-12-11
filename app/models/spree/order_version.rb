class Spree::OrderVersion < ActiveRecord::Base
  belongs_to :order

  serialize :status, Hash

  validates :order, presence: true

  def self.make_version(order:)
    status =  {
                products: order.products.map{|product| product.current_version.id},
                taxons: [],
                variants: [],
                option_types: []
              }

    create status: status, order: order
  end

  private
    def method_missing(m, *args, &block)
      if m.to_sym == :products
        Spree::Product.find status[:products]
      else
        super(m, *args, &block)
      end
    end
end
