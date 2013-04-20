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
  s.summary     = "Rails extension to get country name or country code from an IP address."
  s.description = "IpToCountry is a simple rails tool to determine the origin (ISO country code or country name) of an IP address. The gem uses data from GeoLite by MaxMind."

  s.files = Dir["{app,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.12"
end
