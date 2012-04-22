# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = "sprockets-commonjs"
  s.version     = '0.0.3'
  s.authors     = ["Alex MacCaw"]
  s.email       = ["info@eribium.org"]
  s.homepage    = ""
  s.summary     = %q{Adds CommonJS support to Sprockets}
  s.description = s.summary

  s.rubyforge_project = "sprockets-commonjs"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  s.add_runtime_dependency "sprockets", "~>2.1.2"
end