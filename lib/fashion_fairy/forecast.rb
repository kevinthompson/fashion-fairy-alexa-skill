require 'json'
require 'weather-api'

module FashionFairy
  class Forecast
    attr_reader :location

    delegate :code, :high, :low, :text, to: :today
    delegate :temp, to: :current

    def initialize(location:)
      @location = location
    end

    def to_s
      %(
        Right now in #{city} it's #{temp} degrees #{condition_term(code: code, current: true)} #{current.text}.
        Later #{condition_term(code: code, current: true)} #{text == current.text ? 'more of the same' : text}
        with a high of #{high} degrees.
      )
    end

    private

    attr_reader :data

    def city
      weather.location.city
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

    def condition_term(code:, current: false)
      case code
      when 0..2
        if current
          'with a'
        else
          %(there's going to be a)
        end
      when 20, 22..34, 36, 44
        if current
          'and'
        else
          %(it's going to be)
        end
      else
        if current
          'with'
        else
          %(there's going to be)
        end
      end
    end
  end
end
