require 'sprockets'
require 'tilt'

module Sprockets
  class CommonJS < Tilt::Template

    DEFINE_WRAPPER = '%s.define({%s:' +
                     'function(exports, require, module){' +
                     '%s' +
                     ";}});\n"

    class << self
      attr_accessor :default_namespace
    end

    self.default_mime_type = 'application/javascript'
    self.default_namespace = 'this.require'

    def prepare
      @namespace = self.class.default_namespace
    end

    def evaluate(scope, locals, &block)
      if commonjs_module?(scope)
        path = scope.logical_path
        path = path.gsub(/^\.?\//, '') # Remove relative paths
        path = path.chomp('.module')   # Remove module ext

        scope.require_asset 'sprockets/commonjs'

        WRAPPER % [ namespace, path.inspect, data ]
      else
        data
      end
    end

    private

    attr_reader :namespace

    def commonjs_module?(scope)
      File.extname(scope.logical_path) == '.module'
    end

  end

  register_postprocessor 'application/javascript', CommonJS
  append_path File.expand_path('../../../assets', __FILE__)
end
