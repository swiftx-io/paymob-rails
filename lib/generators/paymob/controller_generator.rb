# frozen_string_literal: true

module Paymob
  module Generators
    class ControllerGenerator < Rails::Generators::Base
      source_root File.expand_path('templates', __dir__)

      argument :mount_path, type: :string, default: ''

      def create_initializer_file
        destination_path = if mount_path.present?
                             "app/controllers/#{mount_path}/paymob_controller.rb"
                           else
                             'app/controllers/paymob_controller.rb'
                           end
        copy_file('paymob_controller.rb', destination_path)
      end
    end
  end
end
