IpToCountry [![Gem Version](https://badge.fury.io/rb/ip_to_country.png)](http://badge.fury.io/rb/ip_to_country) [![Build Status](https://travis-ci.org/vincent-pochet/ip_to_country.png?branch=master)](https://travis-ci.org/vincent-pochet/ip_to_country) [![Dependency Status](https://gemnasium.com/vincent-pochet/ip_to_country.png)](https://gemnasium.com/vincent-pochet/ip_to_country) [![Code Climate](https://codeclimate.com/github/vincent-pochet/ip_to_country.png)](https://codeclimate.com/github/vincent-pochet/ip_to_country) [![Coverage Status](https://coveralls.io/repos/vincent-pochet/ip_to_country/badge.png?branch=master)](https://coveralls.io/r/vincent-pochet/ip_to_country)
=====

Description and documentation comming soon

Installation
------------

Add the following line to your gemfile:

    gem 'geocoder'

and run command

    bundle install

Generate migration

    rails generate geoip
    rake db:migrate
    rake ip_to_country:populate

Geoip model
------------


Request location
------------

The gem add an extension to Rack::Request to quickly get the country code/name of a request.

In your controller, you can do:

    request.geoip.country_name
    request.geoip.country_code

Development
-----------

### Author

[Vincent Pochet](https://github.com/vincent-pochet) ([@vin100pochet](https://twitter.com/vin100pochet))

GeoLite Data
-----------

This product includes GeoLite data created by MaxMind, available from (http://www.maxmind.com).