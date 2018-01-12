require_relative '../intent'
require_relative '../response'

module FashionFairy
  module Alexa
    class Intent
      class HelpIntent < Intent
        def response
          FashionFairy::Alexa::Response.new(
            text: %(
              <prosody pitch="high">
                I can help you pick what to wear today. o
                All you have to do is say, "what should I wear"!
              </prosody>
            ),
            should_end_session: false
          )
        end
      end
    end
  end
end
