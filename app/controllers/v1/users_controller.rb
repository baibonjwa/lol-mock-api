# frozen_string_literal: true

module V1
  # UsersController
  class UsersController < ApiController
    def index
      render json: {
        data: []
      }
    end

    def show
      render json: {
        data: User.find(params[:id])
      }
    end
  end
end
