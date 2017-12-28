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
      upcoming_period.name
    end

    def temperature
      upcoming_period.temperature
    end

    def description
      upcoming_period.description
    end

    def to_s
      %(
        Right now in #{location.city}, #{location.state} it's
        #{current_period.temperature} degrees. #{name} it's going to be
        #{temperature} degrees and #{description}.
      )
    end

    private

    attr_reader :data

    def current_period
      @current_period ||= hours.first
    end

    def upcoming_period
      @upcoming_period ||= FashionFairy::Forecast::Period.new(
        data: periodically.dig('properties', 'periods').first
      )
    end

    def hours
      @hours ||= hourly.dig('properties', 'periods').map do |period|
        FashionFairy::Forecast::Period.new(data: period)
      end
    end

    def periodically
      @periodically ||= weather.forecast
    end

    def hourly
      @hourly ||= weather.hourly
    end

    def weather
      @weather ||= FashionFairy::Weather.new(location: location)
    end
  end
end
