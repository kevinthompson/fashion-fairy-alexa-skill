require_relative 'article'

module FashionFairy
  class Recommendation
    class Accessory < Article
      def to_s
        if forecast.text[/rain/i]
          'an umbrella'
        else
          case forecast.low
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
