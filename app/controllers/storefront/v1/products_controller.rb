module Storefront::V1
  class ProductsController < ApplicationController
    def index
      products = Product.includes(:category).available.ordered
      render json: products, include: :category
    end

    def show
      product = Product.available.find(params[:id])
      render json: product, include: :category
    end
  end
end
