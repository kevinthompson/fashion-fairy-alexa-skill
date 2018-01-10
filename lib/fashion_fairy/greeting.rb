module FashionFairy
  class Greeting
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
        %(
          <say-as interpret-as="interjection">Hello sunshine!</say-as>
          Let's put a sparkle in your step!
        ),
        %(
          I'm warming up my magic wand! Let's see what we can come up with!
        ),
      ]
    end
  end
end
