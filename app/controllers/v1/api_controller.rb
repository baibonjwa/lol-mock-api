# frozen_string_literal: true

# app/controllers/api/v2/api_controller.rb
module V1
  # Base API controller
  class ApiController < ApplicationController
    before_action :cors_preflight_check, :general_error_handling
    after_action :cors_set_access_control_headers, :set_response_headers

    def authenticate_user
      if token
        # decoded_token = JWT.decode(token, hmac_secret, true, { algorithm: 'HS256' })
        # @current_user = decoded_token
      else
        unauthorized_error_handling
      end
    end

    def general_error_handling
      if request.headers['Content-Type'].present? &&
         request.headers['Content-Type'] != 'application/vnd.api+json'
        unsupported_media_type_error_handling
        return
      end
      if !request.headers['Accept'] ||
         request.headers['Accept'] != 'application/vnd.api+json'
        unauthorized_error_handling
        return
      end
    end

    def unsupported_media_type_error_handling
      render status: 415, json: {
        errors: [{
          status: 415,
          code: 1,
          title: '415 Unsupported Media Type',
          detail: 'The request entity has a media type which the server' \
            'or resource does not support.'
        }]
      }
    end

    def not_acceptable_error_handling
      render status: 406, json: {
        errors: [{
          status: 406,
          code: 2,
          title: '406 Not Acceptable',
          detail: 'The requested resource is only capable of generating' \
            'content not acceptable according to the Accept headers sent' \
            'in the request.'
        }]
      }
    end

    def unauthorized_error_handling
      render status: 401, json: {
        errors: [{
          status: 401,
          code: 3,
          title: '401 Unauthorized',
          detail: '401 Unauthorized'
        }]
      }
    end

    def set_response_headers
      response.set_header('Content-Type', 'application/vnd.api+json')
    end

    def cors_set_access_control_headers
      headers['Access-Control-Allow-Origin'] = '*'
      headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT, DELETE, OPTIONS'
      headers['Access-Control-Allow-Headers'] = 'Origin, Content-Type, Accept, Authorization, Token'
      headers['Access-Control-Max-Age'] = '1728000'
    end

    def cors_preflight_check
      return if request.method != 'OPTIONS'
      headers['Access-Control-Allow-Origin'] = '*'
      headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT, DELETE, OPTIONS'
      headers['Access-Control-Allow-Headers'] = 'X-Requested-With, X-Prototype-Version, Token'
      headers['Access-Control-Max-Age'] = '1728000'
      render text: '', content_type: 'text/plain'
    end

    private

    def token
      params[:token] ||
        params[:access_token] ||
        params[:id_token] ||
        token_from_request_headers
    end

    def token_from_request_headers
      auth_header = request.headers['Authorization']
      auth_header.split.last if auth_header.present?
    end
  end
end
