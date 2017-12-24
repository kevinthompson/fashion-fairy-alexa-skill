require 'csv'
require 'httparty'

module FashionFairy
  class Location
    DATA_PATH = '../../data/zip_codes_states.csv'.freeze

    attr_reader :zip_code, :latitude, :longitude, :city, :state, :county

    def self.data
      @data ||= begin
        CSV.read(File.expand_path(DATA_PATH, File.dirname(__FILE__)), headers: true)
      end
    end

    def self.from_zip_code(zip_code)
      row = data.find { |r| r['zip_code'] == zip_code.to_s.rjust(5, '0') }
      new(row) if row
    end

    def initialize(attributes)
      attributes.each do |key, value|
        instance_variable_set("@#{key}", value)
      end
    end

    def time_zone
      @time_zone ||= begin
        url = "https://maps.googleapis.com/maps/api/timezone/json"
        url << "?location=#{latitude},#{longitude}"
        url << "&timestamp=#{Time.now.to_i}"
        url << "&key=#{ENV['GOOGLE_MAPS_API_KEY']}"
        HTTParty.get(url).parsed_response['timeZoneId']
      end
    end
  end
end
