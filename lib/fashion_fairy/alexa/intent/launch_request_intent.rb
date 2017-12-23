require_relative '../intent'
require_relative '../response'

module FashionFairy
  module Alexa
    class Intent
      class LaunchRequestIntent < Intent
        def response
          FashionFairy::Alexa::Response.new(
            text: %(Hi, I'm the fashion fairy! How can I help you today?),
            should_end_session: false
          )
        end
      end
    end
  end
end
