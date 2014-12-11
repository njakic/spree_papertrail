class Spree::OrderVersion < ActiveRecord::Base
  belongs_to :order

  serialize :status, Hash

  validates :order, presence: true

  def products
    versions = PaperTrail::Version.where(id: status[:products])
    versions.map &:reify
  end

  def taxons(product_id:)
    taxon_ids = []

    status[:taxons].each do |taxon|
      taxon_ids += taxon[product_id].to_a
    end

    versions = PaperTrail::Version.where(id: taxon_ids)
    versions.map(&:reify)
  end

  def variants(product_id:)
    variant_ids = []

    status[:variants].each do |variant|
      if value = variant[product_id]
        variant_ids += value.is_a?(Array) ? value : [value]
      end
    end

    versions = PaperTrail::Version.where(id: variant_ids)
    versions.map(&:reify)
  end

  def option_types(product_id:)
    option_type_ids = []

    status[:option_types].each do |option_type|
      if value = option_type[product_id]
        option_type_ids += value.is_a?(Array) ? value : [value]
      end
    end

    versions = PaperTrail::Version.where(id: option_type_ids)
    versions.map(&:reify)
  end

  def option_values(variant_id:)
    option_value_ids = []

    status[:option_values].each do |option_value|
      if value = option_value[variant_id]
        option_value_ids += value.is_a?(Array) ? value : [value]
      end
    end

    versions = PaperTrail::Version.where(id: option_value_ids)
    versions.map(&:reify)
  end

  def self.make_version(order:)
    status =  {
                products: product_versions(order: order),
                taxons: taxon_versions(order: order),
                variants: variant_versions(order: order),
                option_types: option_type_versions(order: order),
                option_values: option_values_versions(order: order)
              }

    create status: status, order: order
  end

  private
    def self.product_versions(order:)
      order.products.map(&:current_version_id)
    end

    def self.taxon_versions(order:)
      order.products.map do |product|
        { product.id => product.taxons.map(&:current_version_id) }
      end
    end

    def self.variant_versions(order:)
      order.variants.map do |variant|
        { variant.product_id => variant.current_version.id }
      end
    end

    def self.option_type_versions(order:)
      order.products.map do |product|
        { product.id => product.option_types.map(&:current_version_id) }
      end
    end

    def self.option_values_versions(order:)
      order.variants.map do |variant|
        { variant.id => variant.option_values.map(&:current_version_id) }
      end
    end
end
