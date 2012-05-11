if defined?(Rails)
  module Sprockets
    class CommonJSEngine < Rails::Engine
      initializer :setup_closure do |app|
        app.assets.register_postprocessor 'application/javascript', CommonJS
      end
    end
  end
end