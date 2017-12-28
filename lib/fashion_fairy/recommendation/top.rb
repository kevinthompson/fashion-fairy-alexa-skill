module FashionFairy
  class Recommendation
    class Top
      def initialize(forecast:)
        @forecast = forecast
      end

      def to_s
        case forecast.temperature
        when -Float::INFINITY..74
          'long-sleeve shirt'
        when 75..Float::INFINITY
          't-shirt'
        end
      end

      private

      attr_reader :forecast
    end
  end
end
