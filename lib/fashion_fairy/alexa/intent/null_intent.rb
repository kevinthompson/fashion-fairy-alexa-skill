require_relative '../intent'
require_relative '../response'

module FashionFairy
  module Alexa
    class Intent
      class NullIntent < Intent
        def response
          FashionFairy::Alexa::Response.new(
            text: %(Sorry, I'm not sure how to respond to that.)
          )
        end
      end
    end
  end
end
