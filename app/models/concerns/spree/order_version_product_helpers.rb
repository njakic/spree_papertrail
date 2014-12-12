module Spree
  module OrderVersionProductHelpers
    def products
      version_ids = status[:products].collect {|item| item[:version_id] }

      versions = PaperTrail::Version.where(id: version_ids)
      versions.map &:reify
    end

    def product(product_id:)
      version_id = status[:products].collect {|item| item[:version_id] if item[:product_id] == product_id}.compact.first

      version = PaperTrail::Version.find_by(id: version_id)
      version.try(:reify)
    end

    private
      def self.product_versions(order:)
        order.products.map do |product|
          { product_id: product.id, version_id: product.current_version_id }
        end
      end
  end
end