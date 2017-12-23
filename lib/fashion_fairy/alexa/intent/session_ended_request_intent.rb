require_relative '../intent'
require_relative '../response'

module FashionFairy
  module Alexa
    class Intent
      class SessionEndedRequestIntent < Intent
        def response
          FashionFairy::Alexa::Response.new
        end
      end
    end
  end
end
