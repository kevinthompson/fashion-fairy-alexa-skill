require_relative '../intent'
require_relative '../response'
require_relative '../../comment'
require_relative '../../farewell'
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
                #{comment}
                #{recommendation}
                #{farewell}
                <audio src="https://23ef47e9.ngrok.io/audio/dissapear.mp3" />
              </speak>
            )
          )
        end

        private

        def comment
          FashionFairy::Comment.new(forecast: forecast)
        end

        def farewell
          FashionFairy::Farewell.new(forecast: forecast)
        end

        def greeting
          FashionFairy::Greeting.new(forecast: forecast)
        end

        def recommendation
          FashionFairy::Recommendation.new(forecast: forecast)
        end

        def forecast
          @forecast ||= FashionFairy::Forecast.new(location: location)
        end
      end
    end
  end
end
