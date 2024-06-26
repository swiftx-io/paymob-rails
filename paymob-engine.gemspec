# frozen_string_literal: true

require_relative 'lib/paymob/engine/version'

Gem::Specification.new do |spec|
  spec.name        = 'paymob-engine'
  spec.version     = Paymob::Engine::VERSION
  spec.authors     = ['khaledmustafa91']
  spec.email       = ['khaled.mustafa1297@gmail.com']
  spec.homepage    = 'https://github.com/swiftx-io/paymob-rails'
  spec.summary     = 'Integration with paymob service'
  spec.description = 'Gem provide you helpers to integrate with paymob service'
  spec.license     = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the "allowed_push_host"
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  # spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/swiftx-io/paymob-rails'
  spec.metadata['changelog_uri'] = 'https://github.com/swiftx-io/paymob-rails'

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']
  end

  spec.required_ruby_version = '>= 2.6.0'
  spec.add_dependency 'httparty'
  spec.add_dependency 'net-http'
  spec.add_dependency 'rails', '>= 6.1.4'
  spec.add_development_dependency 'rspec-rails', '~> 6.1.0'
  spec.metadata['rubygems_mfa_required'] = 'true'
end
