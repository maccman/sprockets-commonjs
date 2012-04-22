if defined?(Rails)
  module Sprockets
    class CommonJSEngine < Rails::Engine
      config.after_initialize do
        Rails.application.assets.register_postprocessor 'application/javascript', CommonJS
        Rails.application.assets.append_path File.expand_path('../..', __FILE__)
      end
    end
  end
end