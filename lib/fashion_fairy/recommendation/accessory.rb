require_relative 'article'

module FashionFairy
  class Recommendation
    class Accessory < Article
      def to_s
        if forecast.description[/rain/i]
          'an umbrella'
        else
          case forecast.temperature
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
