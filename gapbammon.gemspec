# -*- encoding: utf-8 -*-
require File.expand_path('../lib/gapbammon/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Madis Pink", "Uku Loskit", "Lauris Kruusamäe"]
  gem.email         = ["madis.pink@mobisolutions.com"]
  gem.description   = %q{A two-player CLI backgammon game}
  gem.summary       = %q{Student project. Tartu Universiry 2012.}
  gem.homepage      = "http://github.com/madisp/gapbammon"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = %w{gapbammon}
#  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "gapbammon"
  gem.require_paths = ["lib"]
  gem.version       = Gapbammon::VERSION
end
