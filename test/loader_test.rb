# -*- encoding : utf-8 -*-
require 'test_helper'

class LoaderTest < ActiveSupport::TestCase
  
  def test_populate!
    IpToCountry::Loader.expects(download_and_unzip_ips: true, create_tempo_table: true, 
      load_csv_in_tempo_table: true, rename_tempo_into_geoip: true, 
      clean_tmp_files: true)
    assert(IpToCountry::Loader.populate!)
  end

  def test_download_and_unzip_ips
    setup_download_and_extract
    
    IpToCountry::Loader.expects(:system).with("wget -N #{IpToCountry::Loader::ARCHIVE_SOURCE}")
    IpToCountry::Loader.expects(:system).with("unzip -j /tmp/test_ips.zip -d /tmp")
    IpToCountry::Loader.download_and_unzip_ips
    assert File.exists?('/tmp/test_ips.csv')
    
    teardown_download_and_extract
  end

  def test_create_tempo_table
    assert(IpToCountry::Loader.create_tempo_table)
    assert ActiveRecord::Base.connection.table_exists?('geoips_tempo')
  end

  def test_load_csv_in_tempo_table
    setup_load_csv
    IpToCountry::Loader.create_tempo_table
    IpToCountry::Loader.load_csv_in_tempo_table
    IpToCountry::Loader.rename_tempo_into_geoip
    assert_equal 'France', IpToCountry::Geoip.by_ip('2.22.160.0').country_name
    teardown_load_csv
  end

  def test_rename_tempo_into_geoip
    IpToCountry::Loader.create_tempo_table
    IpToCountry::Loader.rename_tempo_into_geoip
    refute ActiveRecord::Base.connection.table_exists?('geoips_tempo')
  end

  def test_clean_tmp_files
    setup_file_remove
    IpToCountry::Loader.clean_tmp_files
    refute File.exists?('/tmp/test_ips.csv')
    refute File.exists?('/tmp/test_ips.zip')
    teardown_file_remove
  end

  private

  def redefine_const(name, value)
    IpToCountry::Loader.send(:remove_const, name) if IpToCountry::Loader.const_defined?(name)
    IpToCountry::Loader.const_set(name, value)
  end

  def setup_download_and_extract
    redefine_const('ARCHIVE_NAME', 'test_ips.zip')
    FileUtils.cp('test/fixtures/ips/test_ips.zip', '.')
    FileUtils.cp('test/fixtures/ips/test_ips.csv', '/tmp')
  end

  def teardown_download_and_extract
    redefine_const('ARCHIVE_NAME', 'GeoIPCountryCSV.zip')
    FileUtils.rm('/tmp/test_ips.csv')
    FileUtils.rm('/tmp/test_ips.zip')
  end

  def setup_load_csv
    FileUtils.cp('test/fixtures/ips/test_ips.csv', '/tmp')
    redefine_const('EXTRACTED_IP_FILE', '/tmp/test_ips.csv')
  end

  def teardown_load_csv
    FileUtils.rm('/tmp/test_ips.csv')
    redefine_const('EXTRACTED_IP_FILE', '/tmp/GeoIPCountryWhois.csv')
  end

  def setup_file_remove
    FileUtils.cp('test/fixtures/ips/test_ips.zip', "/tmp")
    FileUtils.cp('test/fixtures/ips/test_ips.csv', "/tmp")
    redefine_const('EXTRACTED_IP_FILE', '/tmp/test_ips.csv')
    redefine_const('ARCHIVE_NAME', 'test_ips.zip')
  end

  def teardown_file_remove
    redefine_const('EXTRACTED_IP_FILE', '/tmp/GeoIPCountryWhois.csv')
    redefine_const('ARCHIVE_NAME', 'GeoIPCountryCSV.zip')
  end

end
