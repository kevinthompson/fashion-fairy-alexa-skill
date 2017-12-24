module FashionFairy
  class Forecast
    class Period
      def initialize(data:)
        @data = data
      end

      def name
        data.dig('name')
      end

      def temperature
        data.dig('temperature')
      end

      def description
        data.dig('shortForecast')
      end

      private

      attr_reader :data
    end
  end
end
