module Spree
  module OrderVersionProductHelpers
    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      def product_versions(order:)
        order.products.map do |product|
          { product_id: product.id, version_id: product.current_version_id }
        end
      end
    end

    # Entrega los id de las versiones de todos los productos
    def products_version_ids
      if status[:products]
        status[:products].collect do |item|
          item[:version_id]
        end.compact
      else
        []
      end
    end

    # Entrega todos los productos en sus respectivas versiones
    def products
      version_ids = products_version_ids

      versions = PaperTrail::Version.where(id: version_ids)
      versions.map &:reify
    end

    # Entrega el id de la version del producto con id dado
    def product_version_id(product_id:)
      if status[:products]
        status[:products].collect do |item|
          item[:version_id] if item[:product_id] == product_id
        end.compact.first
      else
        nil
      end
    end

    # Entrega el producto con id dado en su respectiva version
    def product(product_id:)
      if version_id = product_version_id(product_id: product_id)
        version = PaperTrail::Version.find_by(id: version_id)
        version.try(:reify)
      else
        return nil
      end
    end
  end
end
