# -*- encoding : utf-8 -*-
Rails.application.routes.draw do

  mount IpToCountry::Engine => "/ip_to_country"
end
