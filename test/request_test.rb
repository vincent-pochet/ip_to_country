# encoding: utf-8
# Code adapted from geocoder(https://github.com/alexreisner/geocoder)

require 'test_helper'

class RequestTest < Test::Unit::TestCase
  class MockRequest
    include IpToCountry::Request
    attr_accessor :env, :ip
    def initialize(env={}, ip="")
      @env = env
      @ip  = ip
    end
  end
  
  def test_http_x_real_ip
    req = MockRequest.new({"HTTP_X_REAL_IP" => "192.168.1.2"})
    assert req.geoip.is_a?(IpToCountry::Geoip)
  end
  
  def test_http_x_forwarded_for_without_proxy
    req = MockRequest.new({"HTTP_X_FORWARDED_FOR" => "192.168.1.2"})
    assert req.geoip.is_a?(IpToCountry::Geoip)
  end
  
  def test_http_x_forwarded_for_with_proxy
    req = MockRequest.new({"HTTP_X_FORWARDED_FOR" => "192.168.1.2, 192.168.1.7"})
    assert req.geoip.is_a?(IpToCountry::Geoip)
  end

  def test_with_request_ip
    req = MockRequest.new({}, "192.168.1.2")
    assert req.geoip.is_a?(IpToCountry::Geoip)
  end
end
