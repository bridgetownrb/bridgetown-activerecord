# frozen_string_literal: true

require_relative "lib/bridgetown-activerecord/version"

Gem::Specification.new do |spec|
  spec.name          = "bridgetown-activerecord"
  spec.version       = BridgetownActiveRecord::VERSION
  spec.author        = "Bridgetown Team"
  spec.email         = "maintainers@bridgetownrb.com"
  spec.summary       = "Plugin to add ActiveRecord support to Bridgetown sites"
  spec.homepage      = "https://github.com/bridgetownrb/bridgetown-activerecord"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r!^(test|script|spec|features|frontend)/!) }
  spec.test_files    = spec.files.grep(%r!^test/!)
  spec.require_paths = ["lib"]

  spec.required_ruby_version = ">= 2.7.0"

  spec.add_dependency "bridgetown", ">= 1.0", "< 2.0"
  spec.add_dependency "activerecord", "~> 7.0"
  spec.add_dependency "standalone_migrations", "~> 7.0"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake", ">= 13.0"
  spec.add_development_dependency "rubocop-bridgetown", "~> 0.3"
end
