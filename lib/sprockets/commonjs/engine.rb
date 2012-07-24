require 'sprockets/commonjs'

if defined?(Rails)
  module Sprockets
    class CommonJS

      class Engine < Rails::Engine
        initializer :setup_commonjs, :after => "sprockets.environment", :group => :all do |app|
          app.assets.register_postprocessor 'application/javascript', CommonJS
        end
      end

    end
  end
end