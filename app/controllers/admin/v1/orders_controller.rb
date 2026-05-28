module Admin::V1
  class OrdersController < ApiController
    before_action :set_order, only: %i[show update]

    def index
      orders = Order.includes(:user, order_items: :product).order(created_at: :desc)
      render json: orders, include: [:user, { order_items: { include: :product } }]
    end

    def show
      render json: @order, include: [:user, { order_items: { include: :product } }]
    end

    def update
      if @order.update(order_params)
        render json: @order, include: [:user, { order_items: { include: :product } }]
      else
        render_record_errors(@order)
      end
    end

    private

    def set_order
      @order = Order.find(params[:id])
    end

    def order_params
      params.require(:order).permit(:status, :notes)
    end
  end
end
