require 'sprockets'
require 'tilt'

module Sprockets
  class CommonJS < Tilt::Template
    self.default_mime_type = 'application/javascript'

    def self.default_namespace
      'this.require'
    end

    def prepare
      @namespace = self.class.default_namespace
    end

    attr_reader :namespace

    def evaluate(scope, locals, &block)
      if scope.pathname.basename.to_s.include?('.module')
        path = scope.logical_path.inspect

        scope.require_asset 'sprockets/commonjs'

        code = ''
        code << "#{namespace}.define({#{path}:"
        code << 'function(exports, require, module){'
        code << data
        code << ";}});\n"
        code
      else
        data
      end
    end
  end
end

require 'sprockets/commonjs/engine'