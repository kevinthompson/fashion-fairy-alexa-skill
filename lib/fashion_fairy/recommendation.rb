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
        I think you should wear #{clothing_type} clothes,
        like #{articles.to_sentence}.
      )
    end

    private

    attr_reader :forecast

    def clothing_type
      if (forecast.temp - forecast.high).abs >= 20
        'layers of'
      else
        case forecast.high
        when -Float::INFINITY..74
          'warm'
        when 75..Float::INFINITY
          'cool'
        end
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
