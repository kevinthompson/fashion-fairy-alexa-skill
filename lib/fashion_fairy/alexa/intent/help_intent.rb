require_relative '../intent'
require_relative '../response'

module FashionFairy
  module Alexa
    class Intent
      class HelpIntent < Intent
        def response
          FashionFairy::Alexa::Response.new(
            text: %(
              I can help you pick what to wear today, or let you know if it's a
              good day for something you want to wear. All you have to do is ask!
            )
          )
        end
      end
    end
  end
end
