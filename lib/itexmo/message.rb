require 'net/http'
require 'json'

module Itexmo
  class Message
    attr_accessor :api_code, :message, :to

    PARAMS = {}
    API_ENDPOINT = 'https://www.itexmo.com/php_api'

    def initialize(options = {})
      @api_code = Itexmo.configuration.api_code
      @message  = options[:message]
      @priority = options[:priority]
      @to       = options[:to]
    end

    # default is NORMAL
    def priority
      @priority ||= Itexmo.configuration.priority
    end

    def send
      uri = URI(API_ENDPOINT + '/api.php')

      request = Net::HTTP.post_form(uri, parameters)
      response = request.body

      case response
      when '0'
        { code: 200, message: 'Success! Message is now on queue and will be sent soon.' }
      when '1'
        raise Errors::BadRequest, 'Invalid value for parameter to'
      when '2'
        raise Errors::BadRequest, 'Number prefix not supported. Please contact itexmo'
      when '3'
        raise Errors::Authentication, 'Invalid api_code'
      when '4'
        { code: 400, message: 'Maximum Message per day reached. This will be reset every 12MN' }
      when '5'
        raise Errors::BadRequest, 'Maximum allowed characters for message reached'
      when '6'
        { code: 422, message: 'System OFFLINE' }
      when '7'
        raise Errors::Authentication, 'Expired ApiCode'
      when '8'
        { code: 500, message: 'iTexMo Error. Please try again later.' }
      when '9'
        raise Errors::BadRequest, 'Invalid Function Parameters'
      when '10'
        { code: 422, message: "Recipient's number is blocked due to FLOODING, message was ignored" }
      when '11'
        { code: 422, message: "Recipient's number is blocked temporarily due to HARD sending (after 3 retries of sending and message still failed to send) and the message was ignored. Try again after an hour. " }
      when '12'
        raise Errors::BadRequest, "Invalid request. You can't set message priorities on non corporate apicodes"
      when '13'
        raise Errors::BadRequest, "Invalid or Not Registered Custom Sender ID."
      end
    end

    def self.send(options = {})
      instance = new(options)
      instance.send
    end

    private

    def parameters
      PARAMS['1'] = to
      PARAMS['2'] = message
      PARAMS['3'] = api_code
      PARAMS['5'] = priority
      PARAMS
    end
  end
end
