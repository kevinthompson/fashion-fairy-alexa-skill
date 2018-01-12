module FashionFairy
  class Greeting
    def to_s
      %(
        <prosody pitch="high">
          #{greetings.sample}
        </prosody>
      )
    end

    private

    def greetings
      [
        %(
            <say-as interpret-as="interjection">All righty!</say-as>
            Let's figure out your outfit.
        ),
        %(
          <prosody pitch="high">
            Abracadabra, make an outfit appear!
          </prosody>
        ),
        %(
          <prosody pitch="high">
            Hello sunshine! Let's put a sparkle in your step!
          </prosody>
        ),
        %(
          <prosody pitch="high">
            I'm warming up my magic wand! Let's see what we can come up with!
          </prosody>
        ),
      ]
    end
  end
end
