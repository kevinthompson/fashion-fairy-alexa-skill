require 'json'
require 'weather-api'

module FashionFairy
  class Forecast
    attr_reader :location

    def initialize(location:)
      @location = location
    end

    def city
      weather.location.city
    end

    def state
      weather.location.region
    end

    def temperature
      weather.forecast.condition.temp
    end

    def description
      weather.forecast.condition.text
    end

    def to_s
      %(
        In #{city}, #{state} it's
        #{temperature} degrees and
        #{description}.
      )
    end

    private

    attr_reader :data

    def weather
      @weather ||= Weather.lookup_by_location(
        location,
        Weather::Units::FAHRENHEIT
      )
    end
  end
end
