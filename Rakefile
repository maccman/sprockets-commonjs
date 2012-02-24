require 'bundler/gem_tasks'
require 'sprockets'
require 'sprockets/commonjs'

task :example do
  env = Sprockets::Environment.new
  env.append_path File.expand_path('../examples', __FILE__)
  env.append_path File.expand_path('../assets/javascripts', __FILE__)
  File.open(File.expand_path('../examples/example.js', __FILE__), 'w+') do |f|
    f.write env['application.js'].to_s
  end
end