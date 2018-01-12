require_relative 'article'

module FashionFairy
  class Recommendation
    class Bottom < Article
      def to_s
        case forecast.high
        when -Float::INFINITY..74
          'pants'
        when 75..Float::INFINITY
          'shorts'
        end
      end
    end
  end
end
