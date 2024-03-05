require_relative "lib/paymob/engine/version"

Gem::Specification.new do |spec|
  spec.name        = "paymob-engine"
  spec.version     = Paymob::Engine::VERSION
  spec.authors     = ["khaledmustafa91"]
  spec.email       = ["khaled.mustafa@cis.asu.edu.eg"]
  spec.homepage    = "https://github.com/khaledmustafa91/paymob"
  spec.summary     = "Integration with paymob service"
  spec.description = "Gem provide you helpers to integrate with paymob service"
  spec.license     = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the "allowed_push_host"
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  # spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/khaledmustafa91/paymob"
  spec.metadata["changelog_uri"] = "https://github.com/khaledmustafa91/paymob"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  end

  spec.add_dependency "rails", ">= 7.0.8"
end
