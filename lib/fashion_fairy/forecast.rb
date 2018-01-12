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
      weather.condition.temp
    end

    def description
      weather.condition.text
    end

    def to_s
      %(
        <prosody pitch="high">
          In #{city}, #{state} it's
          #{temperature} degrees and
          #{description}.
        </prosody>
      )
    end

    private

    attr_reader :data

    def weather
      @weather ||= Weather.lookup_by_location(
        location.zip_code,
        Weather::Units::FAHRENHEIT
      )
    end
  end
end
