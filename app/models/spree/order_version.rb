class Spree::OrderVersion < ActiveRecord::Base
  belongs_to :order

  serialize :status, Hash

  validates :order, presence: true

  def self.make_version(order:)
    status =  {
                products: order.products.map{|product| product.current_version.id},
                taxons: order.products.map{|product| {product.id => product.taxons.map{|taxon| taxon.current_version.id}}},
                variants: [],
                option_types: []
              }

    create status: status, order: order
  end

  def products
    versions = PaperTrail::Version.find(status[:products])
    versions.map &:reify
  end

  def taxons(product_id:)
    taxons = []

    status[:taxons].each do |taxon|
      if taxon_ids = taxon[product_id]
        versions = PaperTrail::Version.find(taxon_ids)
        taxons += versions.map &:reify
      end
    end

    taxons
  end
end
