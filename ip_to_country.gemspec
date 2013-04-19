$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "ip_to_country/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "ip_to_country"
  s.version     = IpToCountry::VERSION
  s.authors     = ["Vincent Pochet"]
  s.email       = ["vincent.pochet@gmail.com"]
  s.homepage    = "https://github.com/vincent-pochet/ip_to_country"
  s.summary     = "TODO: Summary of IpToCountry."
  s.description = "TODO: Description of IpToCountry."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.12" 
  # s.add_dependency "jquery-rails"

  s.add_development_dependency "sqlite3"
end
