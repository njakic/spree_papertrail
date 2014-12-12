module Spree
  module OrderVersionOptionTypeAndValueHelpers
    def option_types(product_id:)
      version_ids = status[:option_types_and_values].collect {|item| item[:option_type_version_id] if item[:product_id] == product_id}.compact

      versions = PaperTrail::Version.where(id: version_ids)
      versions.map(&:reify)
    end

    def option_type(option_type_id:)
      version_id = status[:option_types_and_values].collect {|item| item[:option_type_version_id] if item[:option_type_id] == option_type_id}.compact.first

      version = PaperTrail::Version.find_by(id: version_id)
      version.try(:reify)
    end


    def option_values(variant_id:)
      version_ids = status[:option_types_and_values].collect {|item| item[:option_value_version_id] if item[:variant_id] == variant_id}.compact

      versions = PaperTrail::Version.where(id: version_ids)
      versions.map(&:reify)
    end

    def option_value(option_value_id:)
      version_id = status[:option_types_and_values].collect {|item| item[:option_value_version_id] if item[:option_value_id] == option_value_id}.compact.first

      version = PaperTrail::Version.find_by(id: version_id)
      version.try(:reify)
    end


    def option_type_and_value_version_ids(variant_id:)
      version_ids = status[:option_types_and_values].collect do |item|
        item.select {|key, value| key.match /_version_id$/} if item[:variant_id] == variant_id
      end.compact

      version_ids
    end

    private
      def self.option_type_and_value_versions(order:)
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
end