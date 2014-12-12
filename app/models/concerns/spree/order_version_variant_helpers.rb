module Spree
  module OrderVersionVariantHelpers
    def variants(product_id:)
      version_ids = status[:variants].collect {|item| item[:version_id] if item[:product_id] == product_id}.compact

      versions = PaperTrail::Version.where(id: version_ids)
      versions.map(&:reify)
    end

    def variant(variant_id:)
      version_id = status[:variants].collect {|item| item[:version_id] if item[:variant_id] == variant_id}.compact.first

      version = PaperTrail::Version.find_by(id: version_id)
      version.try(:reify)
    end

    private
      def self.variant_versions(order:)
        order.variants.map do |variant|
          { product_id: variant.product_id, version_id: variant.current_version_id, variant_id: variant.id }
        end
      end
  end
end