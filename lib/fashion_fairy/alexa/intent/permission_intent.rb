require_relative '../intent'
require_relative '../response'

module FashionFairy
  module Alexa
    class Intent
      class PermissionIntent < Intent
        def response
          FashionFairy::Alexa::Response.new(
            text: %(I think you should wear that!)
          )
        end
      end
    end
  end
end
