$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "gera/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
    s.name        = "gera"
    s.version     = Gera::VERSION
    s.authors     = ["Danil Pismenny"]
    s.email       = ["danil@brandymint.ru"]
    s.homepage    = "https://github.com/brandymint/GERA"
    s.summary       = %q{Currency Rates Generator}
    s.description   = %q{Rails On Rails engine to import and generate currency rates}
    s.license     = "GPLv3"

    s.files = Dir["{app,config,db,lib}/**/*", "LICENSE", "Rakefile", "README.md"]

    s.add_dependency "rails", "~> 5.2.1"
    s.add_dependency 'virtus'
    s.add_dependency 'require_all'
    s.add_dependency 'rest-client', '~> 2.0'
    s.add_dependency 'sidekiq'
    s.add_dependency 'auto_logger', '~> 0.1.3'
    s.add_dependency 'request_store'
    s.add_dependency 'business_time'
    s.add_dependency 'dapi-archivable'
    s.add_dependency 'psych'
    s.add_dependency 'money'
    s.add_dependency 'money-rails'
    s.add_dependency 'percentable'

    s.add_development_dependency 'rubocop'
    s.add_development_dependency 'rubocop-rspec'
    s.add_development_dependency 'guard-bundler'
    s.add_development_dependency 'guard-ctags-bundler'
    s.add_development_dependency 'guard-rspec'
    s.add_development_dependency 'guard-rubocop'
    s.add_development_dependency 'byebug'
    s.add_development_dependency 'pry'
    s.add_development_dependency 'pry-doc'
    s.add_development_dependency 'pry-rails'
    s.add_development_dependency 'pry-byebug'
    s.add_development_dependency 'factory_bot'
    s.add_development_dependency 'factory_bot_rails'
    s.add_development_dependency 'rspec-rails', '~> 3.7'
    s.add_development_dependency 'database_rewinder'
    s.add_development_dependency 'mysql2'
    s.add_development_dependency 'vcr'
    s.add_development_dependency 'webmock'
    s.add_development_dependency 'timecop'
    s.add_development_dependency 'yard'
end
