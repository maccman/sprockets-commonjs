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

    protected

    def prepare
      @namespace = self.class.default_namespace
    end

    def evaluate(scope, locals, &block)
      if commonjs_module?(scope)
        scope.require_asset 'sprockets/commonjs'
        WRAPPER % [ namespace, module_name(scope), data ]
      else
        data
      end
    end

    private

    attr_reader :namespace

    def commonjs_module?(scope)
      File.extname(scope.logical_path) == '.module'
    end

    def module_name(scope)
      scope.logical_path.
        gsub(/^\.?\//, ''). # Remove relative paths
        chomp('.module').   # Remove module ext
        inspect
    end

  end

  register_postprocessor 'application/javascript', CommonJS
  append_path File.expand_path('../../../assets', __FILE__)
end
