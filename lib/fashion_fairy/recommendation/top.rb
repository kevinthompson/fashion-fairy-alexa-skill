require_relative 'article'

module FashionFairy
  class Recommendation
    class Top < Article
      def to_s
        case forecast.high
        when -Float::INFINITY..60
          'a long-sleeve shirt'
        when 61..74
          'a t-shirt'
        when 75..85
          'a t-shirt or dress'
        when 86..Float::INFINITY
          'a tank top or dress'
        end
      end
    end
  end
end
