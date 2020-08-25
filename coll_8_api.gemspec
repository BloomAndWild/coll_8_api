require_relative 'lib/coll_8_api/version'

Gem::Specification.new do |spec|
  spec.name          = "coll_8_api"
  spec.version       = Coll8Api::VERSION
  spec.authors       = ["Rachel Bingham"]
  spec.email         = ["rachelb@bloomandwild.com"]

  spec.summary       = "A Ruby interface to the Coll-8 API"
  spec.homepage      = "https://github.com/BloomAndWild/coll_8_api"
  spec.license       = 'Proprietary'

  spec.files         = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'faraday'

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'dotenv'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'vcr'
  spec.add_development_dependency 'webmock'
end
