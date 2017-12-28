module FashionFairy
  class Recommendation
    class Article
      def initialize(forecast:)
        @forecast = forecast
      end

      def to_s
        nil
      end

      private

      attr_reader :forecast
    end
  end
end
