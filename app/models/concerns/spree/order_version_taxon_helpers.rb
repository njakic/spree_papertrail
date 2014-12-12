module Spree
  module OrderVersionTaxonHelpers
    def taxons(product_id:)
      version_ids = status[:taxons].collect {|item| item[:version_id] if item[:product_id] == product_id}.compact

      versions = PaperTrail::Version.where(id: version_ids)
      versions.map(&:reify)
    end

    def taxon(taxon_id:)
      version_id = status[:taxons].collect {|item| item[:version_id] if item[:taxon_id] == taxon_id}.compact.first

      version = PaperTrail::Version.find_by(id: version_id)
      version.try(:reify)
    end

    private
      def self.taxon_versions(order:)
        order.products.includes(:taxons).map do |product|
          product.taxons.map do |taxon|
            { product_id: product.id, version_id: taxon.current_version_id, taxon_id: taxon.id}
          end
        end.flatten
      end
  end
end