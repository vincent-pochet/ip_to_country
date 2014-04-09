# -*- encoding : utf-8 -*-
# Code adapted from geocoder(https://github.com/alexreisner/geocoder)

module IpToCountry
  module Request

    def geoip
      unless defined?(@geoip)
        if env.has_key?('HTTP_X_REAL_IP')
          @geoip = IpToCountry::Geoip.by_ip(env['HTTP_X_REAL_IP'])
        elsif env.has_key?('HTTP_X_FORWARDED_FOR')
          @geoip = IpToCountry::Geoip.by_ip(env['HTTP_X_FORWARDED_FOR'].split(/\s*,\s*/)[0])
        else
          @geoip = IpToCountry::Geoip.by_ip(remote_ip)
        end
      end
      @geoip
    end

  end
end

if defined?(Rack) && defined?(Rack::Request)
  Rack::Request.send :include, IpToCountry::Request
end
