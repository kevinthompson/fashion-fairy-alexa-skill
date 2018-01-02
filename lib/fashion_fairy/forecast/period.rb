module FashionFairy
  class Forecast
    class Period
      def initialize(data:)
        @data = data
      end

      def name
        data.dig('name')
      end

      def starts_at
        Time.parse(data.dig('startTime'))
      end

      def temperature
        data.dig('temperature').to_i
      end

      def description
        data.dig('shortForecast')
      end

      def rain?
        !description[/rain/i].nil?
      end

      def ==(other)
        other.description == description ||
          (other.temperatrure - temperature).abs < 5
      end

      private

      attr_reader :data
    end
  end
end
