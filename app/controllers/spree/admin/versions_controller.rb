module Spree
  module Admin
    class VersionsController < Spree::Admin::BaseController
      def index
        if params[:product_id].present?
          @product = Spree::Product.find_by(slug: params[:product_id])
          @versions = @product.versions

          render :product_versions
        end
      end

      def show
        if params[:product_id].present?
          @taxons = Taxon.order(:name)
          @option_types = OptionType.order(:name)
          @tax_categories = TaxCategory.order(:name)
          @shipping_categories = ShippingCategory.order(:name)

          @versionable = Spree::Product.find_by(slug: params[:product_id])
          @version     = @versionable.versions.find(params[:id])
          @product     = @version.reify

          render :product_version
        end
      end
    end
  end
end