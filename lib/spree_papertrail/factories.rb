versions = {}

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
