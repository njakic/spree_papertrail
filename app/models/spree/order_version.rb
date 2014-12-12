class Spree::OrderVersion < ActiveRecord::Base
  belongs_to :order

  serialize :status, Hash

  validates :order, presence: true

  include Spree::OrderVersionProductHelpers
  include Spree::OrderVersionVariantHelpers
  include Spree::OrderVersionTaxonHelpers
  include Spree::OrderVersionOptionTypeAndValueHelpers

  def self.make_version(order:)
    status =  {
                products: product_versions(order: order),
                variants: variant_versions(order: order),
                taxons: taxon_versions(order: order),
                option_types_and_values: option_type_and_value_versions(order: order)
              }

    create status: status, order: order
  end
end
