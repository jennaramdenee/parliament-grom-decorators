# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'parliament/grom/decorator/version'

Gem::Specification.new do |spec|
  spec.name          = 'parliament-grom-decorators'
  spec.version       = Parliament::Grom::Decorator::VERSION
  spec.authors       = ['Rebecca Appleyard']
  spec.email         = ['rklappleyard@gmail.com']

  spec.summary       = %q{Parliamentary Grom decorator}
  spec.description   = %q{Parliamentary Grom decorator}
  spec.homepage      = 'http://github.com/ukparliament/parliament-grom-decorators'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'i18n'

  spec.add_development_dependency 'bundler', '~> 1.14'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop', '~> 0.51'
  spec.add_development_dependency 'simplecov', '~> 0.12'
  spec.add_development_dependency 'vcr', '~> 3.0'
  spec.add_development_dependency 'webmock', '~> 2.3'
  spec.add_development_dependency 'parliament-ruby'
  spec.add_development_dependency 'parliament-ntriple', '~> 0.2'
  spec.add_development_dependency 'parliament-utils', '~> 0.8'
  spec.add_development_dependency 'timecop', '~> 0.8'
end
