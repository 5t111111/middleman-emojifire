# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "middleman-emojifire/version"

Gem::Specification.new do |spec|
  spec.name        = "middleman-emojifire"
  spec.version     = Middleman::Emojifire::VERSION
  spec.platform    = Gem::Platform::RUBY
  spec.authors     = ["Hirofumi Wakasugi"]
  spec.email       = ["baenej@gmail.com"]
  spec.homepage    = "https://github.com/5t111111/middleman-emojifire"
  spec.summary     = %q{Middleman emoji extension}
  spec.description = %q{middleman-emojifire is a quite easy-to-use emoji extension for Middleman.}

  spec.files         = `git ls-files`.split("\n")
  spec.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  spec.executables   = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "middleman-core", ">= 4.2.1"
  spec.add_runtime_dependency "gemoji", ">= 3.0.0"

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 12.0"
  spec.add_development_dependency "minitest", ">= 5.10"
end
