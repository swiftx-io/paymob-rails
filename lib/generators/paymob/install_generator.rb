# frozen_string_literal: true

module Paymob
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path('templates', __dir__)

      def create_initializer_file
        copy_file('paymob.rb', 'config/initializers/paymob.rb')
      end
    end
  end
end
