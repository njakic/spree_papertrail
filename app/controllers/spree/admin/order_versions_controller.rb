module Spree
  module Admin
    class OrderVersionsController < Spree::Admin::BaseController
      def index
        if params[:order_id].present?
          @order    = Spree::Order.find_by(number: params[:order_id])
          @versions = @order.order_versions.order(id: :desc)
        end
      end

      def show
        if params[:order_id].present?
          @order    = Spree::Order.find_by(number: params[:order_id])
          @version  = @order.order_versions.find(params[:id])
        end
      end
    end
  end
end
