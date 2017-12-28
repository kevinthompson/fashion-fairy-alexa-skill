require 'json'
require_relative 'weather'
require_relative 'forecast/period'

module FashionFairy
  class Forecast
    attr_reader :location

    def initialize(location:)
      @location = location
    end

    def name
      current_period.name
    end

    def temperature
      current_period.temperature
    end

    def description
      current_period.description
    end

    def to_s
      %(
        #{name} in #{location.city}, #{location.state} it's
        #{temperature} degrees and #{description}.
        #{upcoming_forecast}
      )
    end

    private

    attr_reader :data

    def upcoming_forecast
      if current_period.description[/Night/i].nil?
        nil
      elsif upcoming_period.temperature != current_period.temperature
        if upcoming_period.description != current_period.description
          %(
            Later it will be #{upcoming_period.temperature} degrees
            and #{upcoming_period.description}.
          )
        else
          %(Later it will be #{upcoming_period.temperature} degrees.)
        end
      elsif upcoming_period.description != current_period.description
        %(Later it will be #{upcoming_period.description}.)
      end
    end

    def current_period
      @current_period ||= FashionFairy::Forecast::Period.new(
        data: semi_daily.dig('properties', 'periods').first
      )
    end

    def upcoming_period
      hours[3]
    end

    def hours
      @hours ||= hourly.dig('properties', 'periods').map do |period|
        FashionFairy::Forecast::Period.new(data: period)
      end
    end

    def semi_daily
      @semi_daily ||= weather.forecast
    end

    def hourly
      @hourly ||= weather.hourly
    end

    def weather
      @weather ||= FashionFairy::Weather.new(location: location)
    end
  end
end
