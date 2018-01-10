require_relative 'article'

module FashionFairy
  class Recommendation
    class Top < Article
      def to_s
        case forecast.temperature
        when -Float::INFINITY..60
          'a long-sleeve shirt'
        when 61..85
          'a t-shirt'
        when 86..Float::INFINITY
          'a tank top'
        end
      end
    end
  end
end
