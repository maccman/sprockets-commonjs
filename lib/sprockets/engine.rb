if defined?(Rails)
  module Sprockets
    class CommonJSEngine < Rails::Engine
      initializer :setup_closure do |app|
        app.assets.register_postprocessor 'application/javascript', CommonJS
        app.assets.append_path File.expand_path('../..', __FILE__)
      end
    end
  end
end