module FashionFairy
  class Recommendation
    class Bottom
      def initialize(forecast:)
        @forecast = forecast
      end

      def to_s
        case forecast.temperature
        when -Float::INFINITY..74
          'pants'
        when 75..Float::INFINITY
          'shorts'
        end
      end

      private

      attr_reader :forecast
    end
  end
end
