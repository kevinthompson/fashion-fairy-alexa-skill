module FashionFairy
  class Recommendation
    class Accessory
      def initialize(forecast:)
        @forecast = forecast
      end

      def to_s
        case forecast.temperature
        when -Float::INFINITY..60
          'a warm hat'
        when 61..Float::INFINITY
          nil
        end
      end

      private

      attr_reader :forecast
    end
  end
end
