require_relative 'lib/rails_optimizer/version'

Gem::Specification.new do |spec|
  spec.name          = "rails_optimizer"
  spec.version       = RailsOptimizer::VERSION
  spec.authors       = ["Facundo A. Díaz Martínez"]
  spec.email         = ["facundo.martinez@sesocio.com"]

  spec.summary       = %q{Optimze some rails methods}
  spec.description   = %q{Allow to developers increase rails performance in some cases}
  spec.homepage      = "https://github.com/ITSesocio/rails_optimizer"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/ITSesocio/rails_optimizer"
  #spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.add_dependency 'activerecord'
  spec.add_dependency 'activesupport'
end
