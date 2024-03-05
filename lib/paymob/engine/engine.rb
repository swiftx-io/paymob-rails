module Paymob
  module Engine
    class Engine < ::Rails::Engine
      isolate_namespace Paymob::Engine
      config.generators.api_only = true
    end
  end
end
