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
      user = User.find(params[:id])
      render json: UserSerializer.new(user).serialized_json
    end
  end
end
