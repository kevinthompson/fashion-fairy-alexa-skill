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
        %(All righty! Let's figure out your outfit.),
        %(Abracadabra, make an outfit appear!),
        %(Hello sunshine! Let's put a sparkle in your step!),
        %(I'm warming up my magic wand! Let's see what we can come up with!),
      ]
    end
  end
end
