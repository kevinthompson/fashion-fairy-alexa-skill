require_relative 'article'

module FashionFairy
  class Recommendation
    class Outer < Article
      def to_s
        case forecast.code
        when 1..12, 35, 37..40, 45, 47
          'a rain jacket'
        else
          case forecast.temp
          when -Float::INFINITY..60
            'a warm sweater'
          when 61..68
            'a light jacket'
          when 69..Float::INFINITY
            nil
          end
        end
      end
    end
  end
end
