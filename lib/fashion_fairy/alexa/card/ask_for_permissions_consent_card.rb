require_relative '../card'

module FashionFairy
  module Alexa
    class Card
      class AskForPermissionsConsentCard < Card
        def as_hash
          {
            type: 'AskForPermissionsConsent',
            permissions: [
              'read::alexa:device:all:address:country_and_postal_code'
            ]
          }
        end
      end
    end
  end
end
