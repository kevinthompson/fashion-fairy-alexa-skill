require_relative 'article'

module FashionFairy
  class Recommendation
    class Accessory < Article
      def to_s
        if forecast.current.rain? || forecast.upcoming.rain?
          'an umbrella'
        else
          case forecast.current.temperature
          when -Float::INFINITY..65
            'a warm hat'
          when 66..Float::INFINITY
            nil
          end
        end
      end
    end
  end
end
