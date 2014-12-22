module Spree
  module OrderVersionVariantHelpers
    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      def variant_versions(order:)
        order.variants.map do |variant|
          { product_id: variant.product_id, version_id: variant.current_version_id, variant_id: variant.id }
        end
      end
    end

   # Entrega los id de las versiones de todos los Variants
    def variants_version_ids(product_id:)
      if status[:variants]
        status[:variants].collect do |item|
          item[:version_id] if item[:product_id] == product_id
        end.compact
      else
        []
      end
    end

    # Entrega todos los Variants en sus respectivas versiones, asociados al product con id dado
    def variants(product_id:)
      version_ids = variants_version_ids(product_id: product_id)

      versions = PaperTrail::Version.where(id: version_ids)
      versions.map(&:reify)
    end

    # Entrega el id de la version del producto con id dado
    def variant_version_id(variant_id:)
      if status[:variants]
        status[:variants].collect do |item|
          item[:version_id] if item[:variant_id] == variant_id
        end.compact.first
      else
        nil
      end
    end

    # Entrega el producto con id dado en su respectiva version
    def variant(variant_id:)
      version_id = variant_version_id(variant_id: variant_id)

      version = PaperTrail::Version.find_by(id: version_id)
      version.try(:reify)
    end
  end
end