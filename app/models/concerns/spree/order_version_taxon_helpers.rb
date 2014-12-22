module Spree
  module OrderVersionTaxonHelpers
    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      def taxon_versions(order:)
        order.products.includes(:taxons).map do |product|
          product.taxons.map do |taxon|
            { product_id: product.id, version_id: taxon.current_version_id, taxon_id: taxon.id}
          end
        end.flatten
      end
    end

    # Entrega los id de las versiones de todos los Taxons
    def taxons_version_ids(product_id:)
      if status[:taxons]
        status[:taxons].collect do |item|
          item[:version_id] if item[:product_id] == product_id
        end.compact
      else
        []
      end
    end

    # Entrega todos los Taxons en sus respectivas versiones, asociados al product con id dado
    def taxons(product_id:)
      version_ids = taxons_version_ids(product_id: product_id)

      versions = PaperTrail::Version.where(id: version_ids)
      versions.map(&:reify)
    end

    # Entrega el id de la version del producto con id dado
    def taxon_version_id(taxon_id:)
      if status[:taxons]
        status[:taxons].collect do |item|
          item[:version_id] if item[:taxon_id] == taxon_id
        end.compact.first
      else
        nil
      end
    end

    # Entrega el producto con id dado en su respectiva version
    def taxon(taxon_id:)
      version_id = taxon_version_id(taxon_id: taxon_id)

      version = PaperTrail::Version.find_by(id: version_id)
      version.try(:reify)
    end
  end
end