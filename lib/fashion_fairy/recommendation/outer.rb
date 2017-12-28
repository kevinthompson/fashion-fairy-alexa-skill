module FashionFairy
  class Recommendation
    class Outer
      def initialize(forecast:)
        @forecast = forecast
      end

      def to_s
        case forecast.temperature
        when -Float::INFINITY..74
          'a jacket'
        when 75..Float::INFINITY
          nil
        end
      end

      private

      attr_reader :forecast
    end
  end
end
