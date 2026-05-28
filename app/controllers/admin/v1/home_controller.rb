module Admin::V1
  class HomeController < ApiController
    def index
      render json: { message: "Admin API" }
    end
  end
end
