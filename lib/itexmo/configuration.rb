# itexmo module
module Itexmo
  # cofiguration class
  class Configuration
    attr_writer :api_code, :priority

    def initialize
      @api_code = nil
      @priority = 'NORMAL'
    end

    def api_code
      raise Errors::Configuration, 'Itexmo api_code is missing! See documentation for configuration settings.' unless @api_code
      @api_code
    end

    attr_reader :priority
  end
end
