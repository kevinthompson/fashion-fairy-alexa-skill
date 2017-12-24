require_relative '../intent'
require_relative '../response'
require_relative '../../forecast'

module FashionFairy
  module Alexa
    class Intent
      class RecommendationIntent < Intent
        def response
          FashionFairy::Alexa::Response.new(
            text: %(
              <speak>
                <audio src="https://23ef47e9.ngrok.io/audio/appear.mp3" />
                Hello there! #{period.name} in #{location.city} it's
                #{period.temperature} degrees and #{period.description}.
                Sounds like a beautiful day, but a bit chilly.
                I think you should wear warm clothes, like pants, a sweater, and
                maybe a nice hat.
                <audio src="https://23ef47e9.ngrok.io/audio/dissapear.mp3" />
              </speak>
            )
          )
        end

        private

        def forecast
          @forecast ||= FashionFairy::Forecast.for_location(location)
        end

        def period
          @period ||= forecast.periods.first
        end
      end
    end
  end
end
