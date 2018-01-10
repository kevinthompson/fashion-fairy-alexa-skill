require 'csv'
require 'httparty'

module FashionFairy
  class Location
    DATA_PATH = '../../data/zip_codes_states.csv'.freeze
    STATES_PATH = '../../data/states.csv'.freeze

    attr_reader :zip_code, :latitude, :longitude, :city, :state, :county

    @@data = CSV.read(File.expand_path(DATA_PATH, File.dirname(__FILE__)), headers: true)
    @@states = CSV.read(File.expand_path(STATES_PATH, File.dirname(__FILE__)), headers: true)

    def self.data
      @@data
    end

    def self.states
      @@states
    end

    def self.from_zip_code(zip_code)
      row = data.find { |r| r['zip_code'] == zip_code.to_s.rjust(5, '0')[0...5] }
      new(row) if row
    end

    def self.from_city(city, origin: nil)
      matches = data.select { |row| row['city'].downcase == city.downcase }

      if matches.any?
        matches.each do |match|
          match['distance'] = (match['longitude'].to_f - origin.longitude.to_f).abs +
            (match['latitude'].to_f - origin.latitude.to_f).abs
        end

        result = matches.min do |a, b|
          a['distance'] <=> b['distance']
        end

        new(result)
      end
    end

    def self.from_city_state(city, state, origin: nil)
      matches = data.select do |row|
        row['city'].downcase == city.downcase &&
          row['state'].downcase == state.downcase
      end

      if matches.any?
        matches.each do |match|
          match['distance'] = (match['longitude'].to_f - origin.longitude.to_f).abs +
            (match['latitude'].to_f - origin.latitude.to_f).abs
        end

        result = matches.min do |a, b|
          a['distance'] <=> b['distance']
        end

        new(result)
      end
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
