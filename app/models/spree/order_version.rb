class Spree::OrderVersion < ActiveRecord::Base
  belongs_to :order

  serialize :status, Hash

  validates :order, presence: true

  def self.make_version(order:)
    status =  {
                products: order.products.map{|product| product.current_version.id},
                taxons: order.products.map{|product| {product.id => product.taxons.map{|taxon| taxon.current_version.id}}},
                variants: order.variants.map{|variant| {variant.product_id => variant.current_version.id}},
                option_types: order.products.map{|product| {product.id => product.option_types.map{|option_type| option_type.current_version.id}}}
              }

    create status: status, order: order
  end

  def products
    versions = PaperTrail::Version.where(id: status[:products])
    versions.map &:reify
  end

  def taxons(product_id:)
    taxon_ids = []

    status[:taxons].each do |taxon|
      if taxon_ids = taxon[product_id]
        versions = PaperTrail::Version.where(id: taxon_ids)
        taxons += versions.map &:reify
      end
    end

    taxons
  end

  def variants(product_id:)
    variants = []

    status[:variants].each do |variant|
      if variant_ids = variant[product_id]
        versions = PaperTrail::Version.where(id: variant_ids)
        variants += versions.map &:reify
      end
    end

    variants
  end

  def option_types(product_id:)
    option_types = []

    status[:option_types].each do |option_type|
      if option_type_ids = option_type[product_id]
        versions = PaperTrail::Version.where(id: option_type_ids)
        option_types += versions.map &:reify
      end
    end

    option_types
  end
end
