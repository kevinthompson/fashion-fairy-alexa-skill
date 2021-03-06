module FashionFairy
  class Comment
    def initialize(forecast:)
      @forecast = forecast
    end

    def to_s
      case temperature
      when -Float::INFINITY..49
        %(Wow. That's <say-as interpret-as="interjection">freezing</say-as> cold!)
      when 50..59
        %(That's <say-as interpret-as="interjection">pretty</say-as> cold!)
      when 60..68
        %(That sounds a little chilly!)
      when 69..74
        if forecast.text[/sunny/i]
          %(Sounds like a <say-as interpret-as="interjection">beautiful</say-as> day!)
        else
          %(It should feel pretty nice out.)
        end
      when 74..80
        %(That's a bit warm.)
      when 81..Float::INFINITY
        %(Wow. That's <say-as interpret-as="interjection">pretty</say-as> hot.)
      else
      end
    end

    private

    attr_reader :forecast

    def temperature
      if Time.current.hour < 12
        forecast.high
      else
        forecast.temp
      end
    end
  end
end
