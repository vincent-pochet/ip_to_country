# -*- encoding : utf-8 -*-

namespace :ip_to_country do
  
  desc "Populate geoips table from external source"
  task populate: :environment do
    IpToCountry::Loader::populate!
  end

end