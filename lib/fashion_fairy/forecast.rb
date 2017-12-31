require 'json'
require_relative 'weather'
require_relative 'forecast/period'

module FashionFairy
  class Forecast
    attr_reader :location

    def initialize(location:)
      @location = location
    end

    def current
      @current ||= hours.first
    end

    def upcoming
      @upcoming ||= max_offset_hour || current
    end

    def to_s
      %(
        Right now in #{location.city}, #{location.state} it's
        #{current.temperature} degrees and #{current.description}.
        #{upcoming == current ? nil : %(
          Later it's going to be #{upcoming.temperature} degrees
          and #{upcoming.description}.
        )}
      )
    end

    private

    attr_reader :data

    def max_offset_hour
      daytime_hours.max_by do |hour|
        (current.temperature - hour.temperature).abs
      end
    end

    def daytime_hours
      now = Time.now
      limit = Time.new(now.year, now.month, now.day, 20)
      hours.select { |hour| hour.starts_at < limit }
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
