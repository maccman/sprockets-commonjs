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
        { data: WRAPPER % [ input[:name], input[:data] ], dependencies: input[:metadata][:dependencies] << 'sprockets/commonjs' }
      else
        input[:data]
      end
    end

    private

    def commonjs_module?(input)
      input[:name] != 'sprockets/commonjs' && input[:data] =~ /exports/
      #EXTENSIONS.include?(File.extname(scope.logical_path))
    end
  end

  register_postprocessor 'application/javascript', CommonJS
  append_path File.expand_path('../../../assets', __FILE__)
end
