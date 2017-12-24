require_relative '../intent'
require_relative '../response'

module FashionFairy
  module Alexa
    class Intent
      class RecommendationIntent < Intent
        def response
          FashionFairy::Alexa::Response.new(
            text: %(
              <speak>
                <audio src="https://23ef47e9.ngrok.io/audio/magic-wand.mp3" />
                I think you should wear anything you want!
              </speak>
            )
          )
        end
      end
    end
  end
end
