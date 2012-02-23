require 'bundler/gem_tasks'
require 'sprockets'
require 'sprockets/commonjs'

task :example do
  env = Sprockets::Environment.new
  env.append_path File.expand_path('../examples', __FILE__)
  puts env['application.js'].to_s
end