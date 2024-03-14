# frozen_string_literal: true

module Paymob
  module Engine
    class Engine < ::Rails::Engine
      isolate_namespace Paymob::Engine
      config.generators.api_only = true

      config.generators do |g|
        g.test_framework :rspec
      end
    end
  end
end
