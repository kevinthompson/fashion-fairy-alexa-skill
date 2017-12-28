module FashionFairy
  class Greeting
    def initialize(forecast:)
      @forecast = forecast
    end

    def to_s
      greetings.sample
    end

    private

    def greetings
      [
        %(
          <say-as interpret-as="interjection">All righty!</say-as>
          Let's figure out your outfit.
        ),
        %(
          <say-as interpret-as="interjection">Abracadabra</say-as>,
          make an outfit
          <say-as interpret-as="interjection">appear!</say-as>
        ),
      ]

    end

    attr_reader :forecast
  end
end
