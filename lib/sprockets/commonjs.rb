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

    def self.instance
      @instance ||= new
    end

    def self.call(input)
      instance.call(input)
    end

    def call(input)
      name   = input[:name]
      source = input[:data]

      if commonjs_module?(name)
        required  = Set.new(input[:metadata][:required])
        required << add_required(input)

        {
          data: wrap(name, source),
          required: required
        }

      else
        source
      end
    end

    protected

    def wrap(name, source)
      WRAPPER % [ namespace, module_name(name), source ]
    end

    def add_required(input)
      path = input[:environment].resolve("sprockets/commonjs.js")
      'file://%s?type=application/javascript' % path
    end

    def namespace
      self.class.default_namespace
    end

    def commonjs_module?(filename)
      EXTENSIONS.include?(File.extname(filename))
    end

    def module_name(path)
      path.gsub(/^\.?\//, '') # Remove relative paths
          .chomp('.module')   # Remove module ext
          .inspect
    end
  end

  register_postprocessor 'application/javascript', CommonJS
  append_path File.expand_path('../../../assets', __FILE__)
end
