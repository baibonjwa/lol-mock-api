# frozen_string_literal: true

# ApplicationController
class ApplicationController < ActionController::API
  def app_check
    render json: {
      data: {
        sha: `git rev-parse HEAD`
      }
    }
  end
end
