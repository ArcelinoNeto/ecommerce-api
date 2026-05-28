module Admin::V1
  class ApiController < ApplicationController
    include Authenticatable
    before_action :authorize_admin!

    private

    def authorize_admin!
      return if current_user&.admin?

      render json: { error: "Forbidden" }, status: :forbidden
    end
  end
end
