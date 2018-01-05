require_relative '../intent'
require_relative '../response'

module FashionFairy
  module Alexa
    class Intent
      class HelpIntent < Intent
        def response
          FashionFairy::Alexa::Response.new(
            text: %(
              I can help you pick what to wear today. All you have to do is say, "what should I wear"!
            ),
            should_end_session: false
          )
        end
      end
    end
  end
end
