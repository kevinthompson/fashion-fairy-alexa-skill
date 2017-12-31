require_relative 'article'

module FashionFairy
  class Recommendation
    class Outer < Article
      def to_s
        case forecast.current.temperature
        when -Float::INFINITY..65
          'a coat'
        when 66..75
          'a jacket'
        when 76..Float::INFINITY
          nil
        end
      end
    end
  end
end
