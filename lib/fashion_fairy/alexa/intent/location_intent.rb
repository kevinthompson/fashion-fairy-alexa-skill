require_relative '../intent'
require_relative '../response'

module FashionFairy
  module Alexa
    class Intent
      class LocationIntent < Intent
        def response
          FashionFairy::Alexa::Response.new(
            text: %(
              I see that you're in #{location.city} #{location.state}.
              I'll use that when figuring out what you should wear!
            )
          )
        end
      end
    end
  end
end
