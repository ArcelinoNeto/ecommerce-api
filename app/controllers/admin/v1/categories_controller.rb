module Admin::V1
  class CategoriesController < ApiController
    before_action :set_category, only: %i[show update destroy]

    def index
      render json: Category.ordered
    end

    def show
      render json: @category
    end

    def create
      category = Category.new(category_params)

      if category.save
        render json: category, status: :created
      else
        render_record_errors(category)
      end
    end

    def update
      if @category.update(category_params)
        render json: @category
      else
        render_record_errors(@category)
      end
    end

    def destroy
      if @category.destroy
        head :no_content
      else
        render_record_errors(@category)
      end
    end

    private

    def set_category
      @category = Category.find(params[:id])
    end

    def category_params
      params.require(:category).permit(:name, :description)
    end
  end
end
