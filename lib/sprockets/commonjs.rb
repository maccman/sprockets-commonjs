require 'sprockets'
require 'tilt'

module Sprockets
  class CommonJS < Tilt::Template
    ASSETS_PATH = File.expand_path('../../../assets', __FILE__)
    self.default_mime_type = 'application/javascript'

    def self.default_namespace
      'this.require'
    end

    def prepare
      @namespace = self.class.default_namespace
    end

    attr_reader :namespace

    def evaluate(scope, locals, &block)
      path = scope.logical_path.inspect
      code = ''
      code << "#{namespace}.define({#{path}:"
      code << 'function(exports, require, module){'
      code << data
      code << ';}});'
      code
    end
  end

  register_engine '.module', CommonJS
end