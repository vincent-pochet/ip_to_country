# -*- encoding : utf-8 -*-
require 'test_helper'

class GeoipTest < ActionController::TestCase
  
  test "ip_to_integer" do
    assert_equal(3232235778, IpToCountry::Geoip.ip_to_integer("192.168.1.2"))
    assert_equal(0, IpToCountry::Geoip.ip_to_integer(""))
    assert_equal(0, IpToCountry::Geoip.ip_to_integer("wrong.address"))
    assert_equal(0, IpToCountry::Geoip.ip_to_integer(nil))
  end

  test "by_ip" do
    assert_equal 'wonderland', IpToCountry::Geoip.by_ip("192.168.1.2").country_name
  end

end
