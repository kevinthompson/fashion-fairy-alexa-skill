require 'json'
require 'weather-api'

module FashionFairy
  class Forecast
    attr_reader :location

    def initialize(location:)
      @location = location
    end

    def temp
      current.temp
    end

    def low
      today.low
    end

    def high
      today.high
    end

    def text
      today.text
    end

    def to_s
      %(
        Right now in #{city} it's #{current.temp} degrees and #{current.text}.
        Today's forecast is #{today.text} with a high of #{today.high} degrees
        and a low of #{today.low} degrees.
      )
    end

    private

    attr_reader :data

    def city
      weather.location.city
    end

    def state
      weather.location.region
    end

    def current
      weather.condition
    end

    def today
      weather.forecasts.first
    end

    def weather
      @weather ||= Weather.lookup_by_location(
        location.zip_code,
        Weather::Units::FAHRENHEIT
      )
    end
  end
end
