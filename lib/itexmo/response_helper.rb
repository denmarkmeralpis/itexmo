require 'net/http'
require 'json'
# helper
module Itexmo
  # helper
  class ResponseHelper
    attr_accessor :body

    def initialize(body)
      @body = body
    end

    def parse
      case body
      when 'INVALID', 'INVALID_APICODE'
        raise Errors::Authentication, 'invalid api_code'
      when 'INVALID PARAMETERS'
        raise Errors::BadRequest, 'invalid parameters'
      when 'EMPTY'
        []
      when 'ERROR'
        { code: 422, message: 'unable to do action' }
      when 'SUCCESS'
        { code: 200, message: 'action succeeded' }
      when 'NOT_SUPPORTED'
        raise Errors::Authentication, 'api_code is not a corporate one'
      else
        JSON.parse(body, symbolize_names: true)
      end
    end

    def self.parse(body)
      instance = new(body)
      instance.parse
    end
  end
end
