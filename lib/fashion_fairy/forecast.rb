require 'json'
require_relative 'weather'
require_relative 'forecast/period'

module FashionFairy
  class Forecast
    def self.for_location(location)
      new(data: FashionFairy::Weather.new(location: location).forecast)
    end

    def initialize(data:)
      @data = data
    end

    def periods
      data.dig('properties', 'periods').map do |period|
        Period.new(data: period)
      end
    end

    private

    attr_reader :data
  end
end
