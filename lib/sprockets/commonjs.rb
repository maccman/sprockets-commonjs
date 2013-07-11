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

    self.default_mime_type = 'application/javascript'
    self.default_namespace = 'this.require'

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
        scope.require_asset 'sprockets/commonjs'
        WRAPPER % [ namespace, commonjs_module_name(scope), data ]
      else
        data
      end
    end

    private

    attr_reader :namespace

    def commonjs_module?(scope)
      scope.pathname.basename.to_s.include?('.module')
    end

    def commonjs_module_name(scope)
      scope.logical_path.chomp('.module')
    end

  end
end

require 'sprockets/commonjs/engine'
