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
          when -Float::INFINITY..40
            'a warm hat'
          when 66..Float::INFINITY
            if forecast.text[/sunny/i]
              'sunglasses'
            end
          end
        end
      end
    end
  end
end
