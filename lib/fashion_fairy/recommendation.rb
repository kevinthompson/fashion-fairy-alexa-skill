module FashionFairy
  class Recommendation
    attr_reader :forecast

    def initialize(forecast:)
      @forecast = forecast
    end

    def to_s
      %(
        Sounds like a beautiful day, but a bit chilly.
        I think you should wear warm clothes, like pants, a sweater, and
        maybe a nice hat.
      )
    end
  end
end
