# frozen_string_literal: true

require_relative "lib/coll_8_api/version"

Gem::Specification.new do |spec|
  spec.name = "coll_8_api"
  spec.version = Coll8Api::VERSION
  spec.authors = ["Rachel Bingham"]
  spec.email = ["rachelb@bloomandwild.com"]

  spec.summary = "A Ruby interface to the Coll-8 API"
  spec.homepage = "https://github.com/BloomAndWild/coll_8_api"
  spec.license = "Proprietary"

  spec.required_ruby_version = Gem::Requirement.new(">= 3.1.6")
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "faraday", "~> 1.0"
end
