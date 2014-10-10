require 'sprockets/commonjs'

if defined?(Rails)
  module Sprockets
    class CommonJS

      class Engine < ::Rails::Engine
        initializer :setup_commonjs, :after => "sprockets.environment", :group => :all do |app|
          app.assets.register_postprocessor 'application/javascript', CommonJS
        end
      end

    end
  end
else
  module Sprockets
    register_postprocessor 'application/javascript', CommonJS
    append_path File.expand_path('../../../assets/javascripts', __FILE__)
  end
end
