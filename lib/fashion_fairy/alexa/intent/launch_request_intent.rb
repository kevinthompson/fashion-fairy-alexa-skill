require_relative '../intent'
require_relative '../response'

module FashionFairy
  module Alexa
    class Intent
      class LaunchRequestIntent < Intent
        def response
          FashionFairy::Alexa::Response.new(
            text: %(
              #{begin_sound}
              Hi, I'm the fashion fairy.
              #{permission_dependent_phrase}
              #{end_sound}
            ),
            should_end_session: should_end_session
          )
        end

        private

        def permission_dependent_phrase
          if permission_granted?
            %(How can I help you today?)
          else
            %(
              Before I can recommend an outfit, you'll need to give me permission
              to see your zip code in the Alexa app.
            )
          end
        end

        def should_end_session
          !permission_granted?
        end
      end
    end
  end
end
