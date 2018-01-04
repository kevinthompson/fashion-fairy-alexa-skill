require 'csv'
require_relative 'recommendation_intent'

module FashionFairy
  module Alexa
    class Intent
      class CityRecommendationIntent < RecommendationIntent
        private

        def location
          if state
            FashionFairy::Location.from_city_state(city, state, origin: super)
          else
            FashionFairy::Location.from_city(city, origin: super)
          end
        end

        def city
          request.slot('city')
        end

        def state
          @state ||= begin
            state = FashionFairy::Location.states.find(-> { {} }) do |row|
              row['state'].downcase == request.slot('state').to_s.downcase
            end
            state['abbreviation']
          end
        end
      end
    end
  end
end
