lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bigquery-client/version'

Gem::Specification.new do |spec|
  spec.name          = 'bigquery-client'
  spec.version       = BigQuery::Client::VERSION
  spec.authors       = ['Tsukuru Tanimichi']
  spec.email         = ['ttanimichi@hotmail.com']
  spec.summary       = 'A Ruby interface to the BigQuery API.'
  spec.homepage      = 'https://github.com/ttanimichi/bigquery-client'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 1.9.3'

  spec.add_runtime_dependency 'google-api-client', '~> 0.8.0'

  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'test-unit', '~> 3.0.0'
  spec.add_development_dependency 'awesome_print'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'pry-doc'
  spec.add_development_dependency 'pry-byebug'
end
