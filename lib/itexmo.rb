require 'itexmo/version'
require 'itexmo/response_helper'
require 'itexmo/configuration'
require 'itexmo/message'
require 'itexmo/service'
require 'itexmo/sms'
require 'itexmo/errors/authentication'
require 'itexmo/errors/configuration'
require 'itexmo/errors/bad_request'
require 'generators/itexmo/install_generator'

# itexmo configuration block
module Itexmo
  # class
  class << self
    attr_accessor :configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.reset
    @configuration = Configuration.new
  end

  def self.configure
    yield(configuration)
  end
end
