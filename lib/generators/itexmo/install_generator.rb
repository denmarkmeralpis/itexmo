require 'rails/generators'

# name
module Itexmo
  # Generator
  module Generators
    # Class generatpr
    class InstallGenerator < Rails::Generators::NamedBase
      source_root File.expand_path('templates', __dir__)
      desc 'Creates itexmo.rb initializer for your application'

      def copy_initializer
        template 'itexmo_initializer.rb', 'config/initializers/itexmo.rb'
        puts 'Done install! Configure the file in config/initializers/itexmo.rb'
      end
    end
  end
end
