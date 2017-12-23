require_relative '../response'

module FashionFairy
  module Alexa
    class Intent
      class StopIntent < Intent
        def response
          FashionFairy::Alexa::Response.new
        end
      end
    end
  end
end
