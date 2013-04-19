# -*- encoding : utf-8 -*-

class CreateGeoips < ActiveRecord::Migration
  def self.up
    create_table :geoips, id: false do |t|
      t.string :ip_from_string, null: false, limit: 15
      t.string :ip_to_string, null: false, limit: 15
      t.integer :ip_from, null: false, limit: 8
      t.integer :ip_to, null: false, limit: 8
      t.string :country_code, null: false, limit: 2
      t.string :country_name, null: false, limit: 64
    end

    execute "ALTER TABLE geoips ADD CONSTRAINT geoips_pkey PRIMARY KEY(ip_from, ip_to);"

    add_index :geoips, :ip_from, unique: true
    add_index :geoips, :ip_to, unique: true
  end

  def self.down
    drop_table :geoips
  end
end
