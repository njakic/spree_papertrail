module Spree
  module OrderVersionOptionTypeAndValueHelpers
    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      def option_type_and_value_versions(order:)
        order.variants.includes(option_values: :option_type).map do |variant|
          variant.option_values.map do |option_value|
            {
              product_id: variant.product_id,
              variant_id: variant.id,
              option_value_version_id: option_value.current_version_id,
              option_value_id: option_value.id,
              option_type_version_id: option_value.option_type.current_version_id,
              option_type_id: option_value.option_type.id
            }
          end
        end.flatten
      end
    end

    ###############
    # OptionTypes #
    ###############

    # Entrega los id de las versiones de todos los OptionTypes, asociados al product con id dado
    def option_types_version_ids(product_id:)
      if status[:option_types_and_values]
        status[:option_types_and_values].collect do |item|
          item[:option_type_version_id] if item[:product_id] == product_id
        end.compact
      else
        []
      end
    end

    # Entrega todos los OptionTypes en sus respectivas versiones, asociados al product con id dado
    def option_types(product_id:)
      version_ids = option_types_version_ids(product_id: product_id)

      versions = PaperTrail::Version.where(id: version_ids)
      versions.map(&:reify)
    end

    # Entrega el id de la version del OptionType con id dado
    def option_type_version_id(option_type_id:)
      if status[:option_types_and_values]
        status[:option_types_and_values].collect do |item|
          item[:option_type_version_id] if item[:option_type_id] == option_type_id
        end.compact.first
      else
        nil
      end
    end

    # Entrega el OptionType con id dado en su respectiva version
    def option_type(option_type_id:)
      version_id = option_type_version_id(option_type_id: option_type_id)

      version = PaperTrail::Version.find_by(id: version_id)
      version.try(:reify)
    end


    ################
    # OptionValues #
    ################

    # Entrega los id de las versiones de todos los OptionValues, asociados a la variante con id dado
    def option_values_version_ids(variant_id:)
      if status[:option_types_and_values]
        status[:option_types_and_values].collect do |item|
          item[:option_value_version_id] if item[:variant_id] == variant_id
        end.compact
      else
        []
      end
    end

    # Entrega todos los OptionValues en sus respectivas versiones, asociados a la variante con id dado
    def option_values(variant_id:)
      version_ids = option_values_version_ids(variant_id: variant_id)

      versions = PaperTrail::Version.where(id: version_ids)
      versions.map(&:reify)
    end

    # Entrega el id de la version del OptionValue con id dado
    def option_value_version_id(option_value_id:)
      if status[:option_types_and_values]
        status[:option_types_and_values].collect do |item|
          item[:option_value_version_id] if item[:option_value_id] == option_value_id
        end.compact.first
      else
        nil
      end
    end

    # Entrega el OptionType con id dado en su respectiva version
    def option_value(option_value_id:)
      version_id = option_value_version_id(option_value_id: option_value_id)

      version = PaperTrail::Version.find_by(id: version_id)
      version.try(:reify)
    end


    ##############################
    # OptionValues + OptionTypes #
    ##############################

    # Entrega todos los OptionValues junto a sus respectivos OptionTypes cada cual en sus respectivas versiones
    # todos ellos asociados a la variante con id dado
    def option_type_and_value_version_ids(variant_id:)
      if status[:option_types_and_values]
        version_ids = status[:option_types_and_values].collect do |item|
          item.select {|key, value| key.match /_version_id$/} if item[:variant_id] == variant_id
        end.compact

        version_ids
      else
        []
      end
    end
  end
end
