require 'sprockets'
require 'tilt'

module Sprockets
  class CommonJS < Tilt::Template

    WRAPPER = '%s.define({"%s":' +
              'function(exports, require, module){' +
              '%s' +
              ";}});\n"

    class << self
      attr_accessor :default_namespace
    end

    def self.default_mime_type
      'application/javascript'
    end

    def self.default_namespace
      'this.require'
    end

    def self.template_path
      lib = Pathname.new(File.expand_path('../..', __FILE__))
      lib.join('assets', 'javascripts')
    end

    protected

    def prepare
      @namespace = self.class.default_namespace
    end

    def evaluate(scope, locals, &block)
      if commonjs_module?(scope)
        scope.require_asset('sprockets/commonjs')
        wrap(scope, data)
      else
        data
      end
    end

    attr_reader :namespace

    private

    def wrap(scope, data)
      WRAPPER % [ namespace, commonjs_module_name(scope), data ]
    end

    def commonjs_module?(scope)
      scope.pathname.basename.to_s.include?('.module')
    end

    def commonjs_module_name(scope)
      scope.logical_path.chomp('.module')
    end

  end
end

require 'sprockets/commonjs/engine'
