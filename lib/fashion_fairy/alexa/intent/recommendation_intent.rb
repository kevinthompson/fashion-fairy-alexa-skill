require_relative '../intent'
require_relative '../response'

module FashionFairy
  module Alexa
    class Intent
      class RecommendationIntent < Intent
        def response
          FashionFairy::Alexa::Response.new(
            text: %(I think you should wear anything you want!)
          )
        end
      end
    end
  end
end
