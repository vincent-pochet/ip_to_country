# -*- encoding : utf-8 -*-

module IpToCountry
  class Geoip < ActiveRecord::Base

    ###################
    ### Validations ###
    ###################

    validates :ip_from_string, presence: true
    validates :ip_to_string, presence: true
    validates :ip_from, presence: true, uniqueness: true, numericality: :only_integer
    validates :ip_to, presence: true, uniqueness: true, numericality: :only_integer
    validates :country_code, presence: true
    validates :country_name, presence: true

    #####################
    ### Class methods ###
    #####################

    def self.by_ip(ip)
      where("ip_from = (select max(ip_from) from geoips where ip_from <= ?) and ip_to = (select min(ip_to)
        from geoips where ip_to >= ?)", ip_to_integer(ip), ip_to_integer(ip)).first
    end

    def self.ip_to_integer(ip)
      (o1, o2, o3, o4) = ip.try(:split, '.')
      (16777216 * o1.to_i) + (65536 * o2.to_i) + (256 * o3.to_i) + o4.to_i
    end

  end
end
