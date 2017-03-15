require 'sprockets'

module Sprockets
  class CommonJS
    WRAPPER = '%s.define({%s:' +
                     'function(exports, require, module){' +
                     '%s' +
                     ";}});\n"

    EXTENSIONS = %w{.module .cjs}

    class << self
      attr_accessor :default_namespace
    end

    self.default_namespace = 'this.require'

    def initialize(filename, &block)
      @filename = filename
      @source   = block.call
    end

    def render(context, empty_hash_wtf)
      self.class.run(@filename, @source, context)
    end

    def self.run(filename, source, context)
      if commonjs_module?(filename)
        context.require_asset 'sprockets/commonjs'

        WRAPPER % [ default_namespace, module_name(filename), source ]
      else
        source
      end
    end

    def self.call(input)
      name    = input[:name]
      source  = input[:data]
      context = input[:environment].context_class.new(input)

      result = run(name, source, context)
      context.metadata.merge(data: result)
    end

    protected

    def self.commonjs_module?(filename)
      EXTENSIONS.include?(File.extname(filename))
    end

    def self.module_name(path)
      path.gsub(/^\.?\//, '') # Remove relative paths
          .chomp('.module')   # Remove module ext
          .inspect
    end
  end

  register_postprocessor 'application/javascript', CommonJS
  append_path File.expand_path('../../../assets', __FILE__)
end
