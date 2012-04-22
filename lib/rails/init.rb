puts 'LOADED'

# Rails 3.2.3 compatibility
Rails.application.assets.register_preprocessor 'application/javascript', Sprockets::CommonJS
Rails.application.assets.append_path File.expand_path('..', __FILE__)