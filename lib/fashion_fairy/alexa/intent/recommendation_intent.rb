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
          if permission_granted?
            if location.present?
              speak(%(
                #{begin_sound}
                #{greeting}
                <break strength="strong"/>
              ))

              scoped_to_time_zone(location.time_zone) do
                recommendation_response
              end
            else
              unknown_location_response
            end
          else
            permission_required_response
          end
        end

        private

        def recommendation_response
          FashionFairy::Alexa::Response.new(
            text: %(
              #{forecast}
              #{comment}
              #{recommendation}
              #{farewell}
              #{end_sound}
            )
          )
        end

        def unknown_location_response
          FashionFairy::Alexa::Response.new(
            text: %(
              #{begin_sound}
              Oh no. My magic isn't strong enough to find you right now.
              If you try again in a little bit we might be able to figure out an outfit.
              #{end_sound}
            ),
          )
        end

        def comment
          FashionFairy::Comment.new(forecast: forecast)
        end

        def farewell
          FashionFairy::Farewell.new
        end

        def greeting
          FashionFairy::Greeting.new
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
