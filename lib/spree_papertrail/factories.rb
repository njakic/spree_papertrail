versions =  {
              products: [{product_id: 1, version_id: 1}],

              option_types_and_values: [{
                                          product_id: 1,
                                          variant_id: 1,
                                          option_value_version_id: 1,
                                          option_value_id: 1,
                                          option_type_version_id: 1,
                                          option_type_id: 1
                                        }],

              product_properties: [{
                                    product_id: 1,
                                    product_property_version_id: 1,
                                    product_property_id: 1,
                                    property_version_id: 1,
                                    property_id: 1
                                  }],

              taxons: [{product_id: 1, version_id: 1, taxon_id: 1}]
            }

FactoryGirl.define do
  # Define your Spree extensions Factories within this file to enable applications, and other extensions to use and override them.
  #
  # Example adding this to your spec_helper will load these Factories for use:
  # require 'spree_papertrail/factories'

  factory :order_version, class: Spree::OrderVersion do
    status versions
    order
  end

  factory :invalid_order_version, class: Spree::OrderVersion do
    order nil
  end
end
