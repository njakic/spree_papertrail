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

    #####################
    # ProductProperties #
    #####################

    # Entrega los id de las versiones de todos los OptionTypes, asociados al product con id dado
    def product_properties_version_ids(product_id:)
      if status[:product_properties]
        status[:product_properties].collect do |item|
          item[:product_property_version_id] if item[:product_id] == product_id
        end.compact
      else
        []
      end
    end

    # Entrega todos los ProductProperties en sus respectivas versiones, asociados al product con id dado
    def product_properties(product_id:)
      version_ids = product_properties_version_ids(product_id: product_id)

      versions = PaperTrail::Version.where(id: version_ids)
      versions.map(&:reify)
    end

    # Entrega el id de la version del ProductProperty con id dado
    def product_property_version_id(product_property_id:)
      if status[:product_properties]
        status[:product_properties].collect do |item|
          item[:product_property_version_id] if item[:product_property_id] == product_property_id
        end.compact.first
      else
        nil
      end
    end

    # Entrega el OptionType con id dado en su respectiva version
    def product_property(product_property_id:)
      version_id = product_property_version_id(product_property_id: product_property_id)

      version = PaperTrail::Version.find_by(id: version_id)
      version.try(:reify)
    end


    ##############
    # Properties #
    ##############

    # Entrega los id de las versiones de todos los Properties, asociados al producto con id dado
    def properties_version_ids(product_id:)
      if status[:product_properties]
        status[:product_properties].collect do |item|
          item[:property_version_id] if item[:product_id] == product_id
        end.compact
      else
        []
      end
    end

    # Entrega todos los Properties en sus respectivas versiones, asociados a la variante con id dado
    def properties(product_id:)
      version_ids = properties_version_ids(product_id: product_id)

      versions = PaperTrail::Version.where(id: version_ids)
      versions.map(&:reify)
    end

    # Entrega el id de la version del Property con id dado
    def property_version_id(property_id:)
      if status[:product_properties]
        status[:product_properties].collect do |item|
          item[:property_version_id] if item[:property_id] == property_id
        end.compact.first
      else
        nil
      end
    end

    # Entrega el Property con id dado en su respectiva version
    def property(property_id:)
      version_id = property_version_id(property_id: property_id)

      version = PaperTrail::Version.find_by(id: version_id)
      version.try(:reify)
    end


    ##################################
    # ProductProperties + Properties #
    ##################################

    # Entrega todos los ProductProperties junto a sus respectivos Properties cada cual en sus respectivas versiones
    # todos ellos asociados a la variante con id dado
    def product_property_and_property_version_ids(product_id:)
      if status[:product_properties]
        version_ids = status[:product_properties].collect do |item|
          item.select {|key, value| key.match /_version_id$/} if item[:product_id] == product_id
        end.compact

        version_ids
      else
        []
      end
    end
  end
end