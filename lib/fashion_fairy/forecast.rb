module FashionFairy
  class Forecast
    def initialize(data:)
      @data = data
    end

    def periods
      data.dig('properties', 'periods').each do |period|
        Period.new(data: period)
      end
    end

    private

    attr_reader :data

    class Period
      def initialize(data:)
        @data = data
      end

      def name
        data.dig('name')
      end

      def

      end

      private

      attr_reader :data
    end
  end
end
