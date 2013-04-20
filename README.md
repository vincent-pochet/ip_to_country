IpToCountry [![Gem Version](https://badge.fury.io/rb/ip_to_country.png)](http://badge.fury.io/rb/ip_to_country) [![Build Status](https://travis-ci.org/vincent-pochet/ip_to_country.png?branch=master)](https://travis-ci.org/vincent-pochet/ip_to_country) [![Dependency Status](https://gemnasium.com/vincent-pochet/ip_to_country.png)](https://gemnasium.com/vincent-pochet/ip_to_country) [![Code Climate](https://codeclimate.com/github/vincent-pochet/ip_to_country.png)](https://codeclimate.com/github/vincent-pochet/ip_to_country) [![Coverage Status](https://coveralls.io/repos/vincent-pochet/ip_to_country/badge.png?branch=master)](https://coveralls.io/r/vincent-pochet/ip_to_country)
=====

IpToCountry is a simple rails extension to find the origin (ISO country code or country name) of an IP address.

IpToCountry only supports ruby 1.9.3, rails 3.2+ and only works with a postgresql database. Support for rails 4 and mysql is planned.

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

All logic takes place in `IpToCountry::Geoip` model

You can find detail of an IP address, using:

    IpToCountry::Geoip.by_ip('192.168.1.34')

Request location
------------

The gem add an extension to `Rack::Request` to quickly get the country code/name origin of a request.

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