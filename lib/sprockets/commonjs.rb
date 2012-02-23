require 'sprockets'
require 'tilt'
require 'holmes'

module Sprockets
  class CommonJS < Tilt::Template
    COMMONJS_PATH = File.expand_path('../../../assets/javascripts/commonjs.js', __FILE__)

    def self.default_mime_type
      'application/javascript'
    end

    def self.default_namespace
      'this.require'
    end

    def prepare
      @namespace = self.class.default_namespace
    end

    attr_reader :namespace

    def evaluate(scope, locals, &block)
      scope.require_asset(COMMONJS_PATH)

      requires = Holmes.parse(data)
      warn 'Dynamic require calls' if requires['expressions'].any?

      requires['strings'].each do |dependency|
        scope.require_asset(dependency)
      end

      <<-JS
(function() {
  #{namespace} || (#{namespace} = {});
  #{namespace}.modules || (#{namespace}.modules = {});
  #{namespace}.modules[#{scope.logical_path.inspect}] = function(exports, require, modules){
    #{indent(data)}
  };
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