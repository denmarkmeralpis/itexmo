require 'net/http'
require 'json'

module Itexmo
  class Service
    attr_accessor :api_code

    API_ENDPOINT = 'https://www.itexmo.com/php_api'

    def initialize
      @api_code = Itexmo.configuration.api_code
    end

    def status
      uri = URI(API_ENDPOINT + '/serverstatus.php')
      uri.query = URI.encode_www_form(parameters)
      request = Net::HTTP.get_response(uri)
      ResponseHelper.parse(request.body)
    end

    def self.status
      instance = new
      instance.status
    end

    def apicode_info
      uri = URI(API_ENDPOINT + '/apicode_info.php')
      uri.query = URI.encode_www_form(parameters)
      request = Net::HTTP.get_response(uri)
      ResponseHelper.parse(request.body)
    end

    def self.apicode_info
      instance = new
      instance.apicode_info
    end

    private

    def parameters
      { 'apicode' => api_code }
    end
  end
end
