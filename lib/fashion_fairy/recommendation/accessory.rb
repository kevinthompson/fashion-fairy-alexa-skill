require_relative 'article'

module FashionFairy
  class Recommendation
    class Accessory < Article
      def to_s
        case forecast.code
        when 1..12, 35, 37..40, 45, 47
          'an umbrella'
        else
          case forecast.temp
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
