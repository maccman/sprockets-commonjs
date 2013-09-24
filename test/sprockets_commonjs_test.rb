require 'test/unit'
require 'tempfile'
require 'sprockets-commonjs'

class SprocketsCommonjsTest < Test::Unit::TestCase

  TEST_DIR = File.expand_path('..', __FILE__)
  LIB_DIR  = File.expand_path('../lib/assets/javascripts', TEST_DIR)

  attr_reader :output

  def setup
    env = Sprockets::Environment.new
    env.register_postprocessor 'application/javascript', Sprockets::CommonJS
    env.append_path TEST_DIR
    env.append_path LIB_DIR
    outfile = Tempfile.new('sprockets-output')
    env['source.js'].write_to outfile.path
    @output = File.read outfile.path
  end

  def test_adds_commonjs_require
    assert_match %r[var require = function\(name, root\) \{], @output
  end

  def test_modularizes_modules
    assert_match %r[require.define\(\{\"foo\":function], @output
    assert_match %r["Foo!"], @output
  end

  def test_does_not_modularize_non_modules
    assert_no_match %r[require.define\(\{\"bar\":function], @output
  end

end
