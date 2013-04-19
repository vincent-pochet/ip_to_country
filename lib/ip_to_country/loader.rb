# -*- encoding : utf-8 -*-

module IpToCountry
  module Loader

    #################
    ### Constants ###
    #################

    ARCHIVE_SOURCE = 'http://geolite.maxmind.com/download/geoip/database/GeoIPCountryCSV.zip'.freeze
    ARCHIVE_NAME = 'GeoIPCountryCSV.zip'.freeze
    EXTRACTED_IP_FILE = '/tmp/GeoIPCountryWhois.csv'.freeze

    #####################
    ### Class methods ###
    #####################

    def self.populate!
      download_and_unzip_ips
      create_tempo_table
      load_csv_in_tempo_table
      rename_tempo_into_geoip
      clean_tmp_files
    end

    def self.download_and_unzip_ips
      system("wget -N #{ARCHIVE_SOURCE}")
      FileUtils.mv(ARCHIVE_NAME, "/tmp")
      system("unzip -j /tmp/#{ARCHIVE_NAME} -d /tmp")
    end

    # Create a tempo geoips table to load ips.
    def self.create_tempo_table
      sql = <<-__SQL__
        DROP TABLE IF EXISTS geoips_tempo;
        CREATE TABLE geoips_tempo AS SELECT * FROM geoips WHERE ip_from = -1;
      __SQL__
      ActiveRecord::Base.connection.execute(sql)
    end

    # Load IPs and countries matching from a CSV file.
    def self.load_csv_in_tempo_table
      raw  = ActiveRecord::Base.connection.raw_connection
      raw.exec("COPY geoips_tempo FROM STDIN WITH(FORMAT CSV)")
      File.open(EXTRACTED_IP_FILE).each do |line|
        raw.put_copy_data line
      end
      raw.put_copy_end
      while res = raw.get_result do; end # very important to do this after a copy
      ActiveRecord::Base.connection_pool.checkin(ActiveRecord::Base.connection)
    end

    def self.rename_tempo_into_geoip
      sql = <<-__SQL__
        ALTER TABLE geoips RENAME TO tmp;
        ALTER TABLE geoips_tempo RENAME TO geoips;
        ALTER TABLE tmp RENAME TO geoips_tempo;
        DROP TABLE geoips_tempo;
      __SQL__
      ActiveRecord::Base.connection.execute(sql)
    end

    def self.clean_tmp_files
      FileUtils.rm(EXTRACTED_IP_FILE)
      FileUtils.rm("/tmp/#{ARCHIVE_NAME}")
    end

  end
end