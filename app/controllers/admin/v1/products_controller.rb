module Admin::V1
  class ProductsController < ApiController
    before_action :set_product, only: %i[show update destroy]

    def index
      products = Product.includes(:category).ordered
      render json: products, include: :category
    end

    def show
      render json: @product, include: :category
    end

    def create
      product = Product.new(product_params)

      if product.save
        render json: product, include: :category, status: :created
      else
        render_record_errors(product)
      end
    end

    def update
      if @product.update(product_params)
        render json: @product, include: :category
      else
        render_record_errors(@product)
      end
    end

    def destroy
      if @product.destroy
        head :no_content
      else
        render_record_errors(@product)
      end
    end

    private

    def set_product
      @product = Product.find(params[:id])
    end

    def product_params
      params.require(:product).permit(:category_id, :name, :description, :price, :stock_quantity, :active)
    end
  end
end
