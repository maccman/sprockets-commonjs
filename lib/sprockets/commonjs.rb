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
      <<-JS
(function() {
  #{namespace}.define({#{scope.logical_path.inspect}: function(exports, require, module){
    #{indent(data)}
  }});
}).call(this);
      JS
    end

    private
      def indent(string)
        string.gsub(/$(.)/m, "\\1  ").strip
      end
  end

  register_engine '.module', CommonJS
end