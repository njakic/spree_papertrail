module Spree
  module OrderVersionProductPropertyHelpers
    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      def product_property_versions(order:)
        order.products.includes(product_properties: :property).map do |product|
          product.product_properties.map do |product_property|
            {
              product_id: product.id,
              product_property_version_id: product_property.current_version_id,
              product_property_id: product_property.id,
              property_version_id: product_property.property.current_version_id,
              property_id: product_property.property.id
            }
          end
        end.flatten
      end
    end

    def product_properties(product_id:)
      version_ids = status[:product_properties].collect {|item| item[:product_property_version_id] if item[:product_id] == product_id}.compact

      versions = PaperTrail::Version.where(id: version_ids)
      versions.map(&:reify)
    end

    def product_property(product_property_id:)
      version_id = status[:product_properties].collect {|item| item[:product_property_version_id] if item[:product_property_id] == product_property_id}.compact.first

      version = PaperTrail::Version.find_by(id: version_id)
      version.try(:reify)
    end


    def properties(product_id:)
      version_ids = status[:product_properties].collect {|item| item[:property_version_id] if item[:product_id] == product_id}.compact

      versions = PaperTrail::Version.where(id: version_ids)
      versions.map(&:reify)
    end

    def property(property_id:)
      version_id = status[:product_properties].collect {|item| item[:property_version_id] if item[:property_id] == property_id}.compact.first

      version = PaperTrail::Version.find_by(id: version_id)
      version.try(:reify)
    end


    def product_property_and_property_version_ids(product_id:)
      version_ids = status[:product_properties].collect do |item|
        item.select {|key, value| key.match /_version_id$/} if item[:product_id] == product_id
      end.compact

      version_ids
    end
  end
end