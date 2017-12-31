require_relative 'article'

module FashionFairy
  class Recommendation
    class Outer < Article
      def to_s
        if forecast.current.rain? || forecast.upcoming.rain?
          'a jacket'
        else
          case forecast.current.temperature
          when -Float::INFINITY..60
            'a warm coat'
          when 61..68
            'a jacket'
          when 69..Float::INFINITY
            nil
          end
        end
      end
    end
  end
end
