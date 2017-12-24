require 'json'
require_relative 'weather'
require_relative 'forecast/period'

module FashionFairy
  class Forecast
    attr_reader :location

    def initialize(location:)
      @location = location
      @data = FashionFairy::Weather.new(location: location).forecast
    end

    def periods
      @periods ||= data.dig('properties', 'periods').map do |period|
        FashionFairy::Forecast::Period.new(data: period)
      end
    end

    def to_s
      %(
        #{periods.first.name} in #{location.city} it's
        #{periods.first.temperature} degrees and #{periods.first.description}.
      )
    end

    private

    attr_reader :data
  end
end
