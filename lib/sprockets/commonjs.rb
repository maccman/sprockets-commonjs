require 'sprockets'

module Sprockets
  class CommonJS
    WRAPPER = 'this.require.define({"%s":' +
    'function(exports, require, module){' +
    '%s' +
    ";}});\n"

    EXTENSIONS = %w{.module .cjs}

    def self.instance
      @instance ||= new
    end
    
    def self.call(input)
      instance.call(input)
    end

    def call(input)
      if commonjs_module?(input)
        required  = Set.new(input[:metadata][:required])
        required << input[:environment].resolve("sprockets/commonjs.js")[0]
        { data: WRAPPER % [ input[:name], input[:data] ], required: required }
      else
        input[:data]
      end
    end

    private

    def commonjs_module?(input)
      EXTENSIONS.include?(File.extname(input[:name]))
    end
  end

  register_postprocessor 'application/javascript', CommonJS
  append_path File.expand_path('../../../assets', __FILE__)
end