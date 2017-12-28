require_relative 'recommendation/top'
require_relative 'recommendation/bottom'
require_relative 'recommendation/outer'
require_relative 'recommendation/accessory'

module FashionFairy
  class Recommendation
    def initialize(forecast:)
      @forecast = forecast
    end

    def to_s
      %(
        I think you should wear #{temperate} clothes,
        like #{articles.to_sentence}.
      )
    end

    private

    attr_reader :forecast

    def temperate
      case forecast.temperature
      when -Float::INFINITY..74
        'warm'
      when 75..Float::INFINITY
        'cool'
      end
    end

    def articles
      [top, bottom, outer, accessory].map(&:to_s).compact
    end

    def top
      FashionFairy::Recommendation::Top.new(forecast: forecast)
    end

    def bottom
      FashionFairy::Recommendation::Bottom.new(forecast: forecast)
    end

    def outer
      FashionFairy::Recommendation::Outer.new(forecast: forecast)
    end

    def accessory
      FashionFairy::Recommendation::Accessory.new(forecast: forecast)
    end
  end
end
