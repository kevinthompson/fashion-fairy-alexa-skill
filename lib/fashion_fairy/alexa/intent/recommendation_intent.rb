require_relative '../intent'
require_relative '../response'
require_relative '../../forecast'
require_relative '../../greeting'
require_relative '../../recommendation'

module FashionFairy
  module Alexa
    class Intent
      class RecommendationIntent < Intent
        def response
          FashionFairy::Alexa::Response.new(
            text: %(
              <speak>
                <audio src="https://23ef47e9.ngrok.io/audio/appear.mp3" />
                #{greeting}
                #{forecast}
                #{recommendation}
                <audio src="https://23ef47e9.ngrok.io/audio/dissapear.mp3" />
              </speak>
            )
          )
        end

        private

        def greeting
          @greeting ||= FashionFairy::Greeting.new(location: location)
        end

        def forecast
          @forecast ||= FashionFairy::Forecast.new(location: location)
        end

        def recommendation
          @recommendation ||= FashionFairy::Recommendation.new(forecast: forecast)
        end
      end
    end
  end
end
