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

    attr_reader :namespace

    def evaluate(scope, locals, &block)
      if scope.pathname.basename.to_s.include?('.module')
        path = scope.logical_path.inspect
        scope.require_asset 'sprockets/commonjs'
        WRAPPER % [ namespace, path, data ]
      else
        data
      end
    end
  end
end

require 'sprockets/commonjs/engine'