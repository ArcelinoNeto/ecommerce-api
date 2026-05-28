module Storefront::V1
  class CategoriesController < ApplicationController
    def index
      render json: Category.ordered
    end

    def show
      category = Category.find(params[:id])
      products = category.products.available.ordered

      render json: category.as_json.merge(products: products.as_json)
    end
  end
end
