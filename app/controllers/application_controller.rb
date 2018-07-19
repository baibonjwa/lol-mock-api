# frozen_string_literal: true

# ApplicationController
class ApplicationController < ActionController::API
  def app_check
    render json: {
      data: {
        sha: `git symbolic-ref -q --short HEAD || git describe --tags --exact-match`
      }
    }
  end
end
