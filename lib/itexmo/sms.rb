require 'net/http'
require 'json'
# module
module Itexmo
  # sms
  class Sms
    attr_accessor :api_code

    API_ENDPOINT = 'https://www.itexmo.com/php_api'.freeze
    PARAMETERS = {}

    def initialize
      @api_code = Itexmo.configuration.api_code
      PARAMETERS['apicode'] = api_code
    end

    def display_outgoing(sortby = 'asc')
      PARAMETERS[:sortby] = sortby
      uri                  = URI(API_ENDPOINT + '/display_outgoing.php')
      uri.query            = URI.encode_www_form(PARAMETERS)
      request              = Net::HTTP.get_response(uri)
      PARAMETERS.except!(:sortby)
      ResponseHelper.parse(request.body)
    end

    def self.display_outgoing(sortby = 'asc')
      instance = new
      instance.display_outgoing(sortby)
    end

    def delete_all_outgoing
      uri = URI(API_ENDPOINT + '/delete_outgoing_all.php')
      uri.query = URI.encode_www_form(PARAMETERS)
      request   = Net::HTTP.get_response(uri)
      ResponseHelper.parse(request.body)
    end

    def self.delete_all_outgoing
      instance = new
      instance.delete_all_outgoing
    end

    def display_messages
      uri = URI(API_ENDPOINT + '/display_messages.php')
      uri.query = URI.encode_www_form(PARAMETERS)
      request   = Net::HTTP.get_response(uri)
      ResponseHelper.parse(request.body)
    end

    def self.display_messages
      instance = new
      instance.display_messages
    end

    def display_messages_via_originator(originator)
      PARAMETERS[:originator] = originator
      uri       = URI(API_ENDPOINT + '/display_messages_via_originator.php')
      uri.query = URI.encode_www_form(PARAMETERS)
      request   = Net::HTTP.get_response(uri)
      PARAMETERS.except!(:originator)
      ResponseHelper.parse(request.body)
    end

    def self.display_messages_via_originator(originator)
      instance = new
      instance.display_messages_via_originator(originator)
    end

    def delete_message_via_originator(originator)
      PARAMETERS[:originator] = originator
      uri       = URI(API_ENDPOINT + '/delete_message_via_originator.php')
      uri.query = URI.encode_www_form(PARAMETERS)
      request   = Net::HTTP.get_response(uri)
      PARAMETERS.except!(:originator)
      ResponseHelper.parse(request.body)
    end

    def self.delete_message_via_originator(originator)
      instance = new
      instance.delete_message_via_originator(originator)
    end

    def delete_message_via_id(id)
      PARAMETERS[:id] = id
      uri       = URI(API_ENDPOINT + '/delete_message_via_id.php')
      uri.query = URI.encode_www_form(PARAMETERS)
      request   = Net::HTTP.get_response(uri)
      PARAMETERS.except!(:id)
      ResponseHelper.parse(request.body)
    end

    def self.delete_message_via_id(originator)
      instance = new
      instance.delete_message_via_id(originator)
    end

    def delete_messages_all
      uri = URI(API_ENDPOINT + '/delete_messages_all.php')
      uri.query = URI.encode_www_form(PARAMETERS)
      request   = Net::HTTP.get_response(uri)
      ResponseHelper.parse(request.body)
    end

    def self.delete_messages_all
      instance = new
      instance.delete_messages_all
    end
  end
end
