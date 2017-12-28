require 'json'
require_relative 'weather'
require_relative 'forecast/period'

module FashionFairy
  class Forecast
    attr_reader :location

    def initialize(location:)
      @location = location
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
        #{current_period.temperature} degrees. Later it's going to be
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
        data: max_offset_hour
      )
    end

    def max_offset_hour
      hours.max do |a,b|
        (current_period.temperature - a.temperature).abs <=>
          (current_period.temperature - b.temperature).abs
      end
    end

    def hours
      @hours ||= weather.hourly.dig('properties', 'periods').map do |period|
        FashionFairy::Forecast::Period.new(data: period)
      end
    end

    def weather
      @weather ||= FashionFairy::Weather.new(location: location)
    end
  end
end
