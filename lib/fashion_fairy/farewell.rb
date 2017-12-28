module FashionFairy
  class Farewell
    def initialize(forecast:)
      @forecast = forecast
    end

    def to_s
      farewells.sample
    end

    private

    def farewells
      [
        %(Have a great day!),
        %(<say-as interpret-as="interjection">Deuces!</say-as>),
        %(Fashion Fairy out!),
      ]
    end

    attr_reader :forecast
  end
end
