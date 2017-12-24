require 'csv'

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
  end
end
