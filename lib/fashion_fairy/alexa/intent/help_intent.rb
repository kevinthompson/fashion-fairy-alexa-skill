require_relative '../intent'
require_relative '../response'

module FashionFairy
  module Alexa
    class Intent
      class HelpIntent < Intent
        def response
          FashionFairy::Alexa::Response.new(
            text: %(
              #{begin_sound}
              I can help you pick what to wear today,
              #{permission_dependent_phrase}
              #{end_sound}
            ),
            should_end_session: should_end_session
          )
        end

        private

        def permission_dependent_phrase
          if permission_granted?
            %(all you have to do is say, "what should I wear?")
          else
            %(
              but before I can recommend an outfit, you'll need to give me permission
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
