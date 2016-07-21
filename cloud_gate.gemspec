lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cloud_gate/version'

Gem::Specification.new do |s|
  s.name        = 'cloud_gate'
  s.version     = CloudGate::VERSION
  s.authors     = ['Pivotal Internal App Development Team']
  s.email       = 'iad-dev@pivotal.io'

  s.summary     = 'Gateway to your cloud data'
  s.description = 'Database tools for Cloud Foundry apps running Pivotal MySQL Service'
  s.homepage    = 'https://github.com/kayline/cloud_gate'
  s.license     = 'MIT'

  s.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  s.bindir        = 'exe'
  s.executables   = s.files.grep(%r{^exe/}) { |f| File.basename(f) }
  s.require_paths = ['lib']

  s.add_dependency('rails', '~> 4.0')

  s.add_development_dependency 'bundler', '~> 1.11'
  s.add_development_dependency 'rake', '~> 11.0'
  s.add_development_dependency 'rspec'
end
