module Storefront::V1
  class OrdersController < ApiController
    before_action :set_order, only: :show

    def index
      orders = current_user.orders.includes(order_items: :product).order(created_at: :desc)
      render json: orders, include: { order_items: { include: :product } }
    end

    def show
      render json: @order, include: { order_items: { include: :product } }
    end

    def create
      order = current_user.orders.new(order_params.except(:items))
      build_items(order)

      if order.save
        render json: order, include: { order_items: { include: :product } }, status: :created
      else
        render_record_errors(order)
      end
    end

    private

    def set_order
      @order = current_user.orders.find(params[:id])
    end

    def build_items(order)
      grouped_items.each do |product_id, quantity|
        order.order_items.build(product_id: product_id, quantity: quantity)
      end
    end

    def order_params
      params.require(:order).permit(:shipping_address, :notes, items: %i[product_id quantity])
    end

    def grouped_items
      order_params.fetch(:items, []).each_with_object(Hash.new(0)) do |item, items|
        items[item[:product_id]] += item[:quantity].to_i
      end
    end
  end
end
