require_relative 'date_range'

module FashionFairy
  module Alexa
    class Intent
      attr_reader :request

      delegate :api, :location, :permission_granted?, :permission_required_response, to: :request

      class << self
        def find(name)
          ObjectSpace.each_object(Class).find do |klass|
            klass < self && klass.name[/\w+$/] == name
          end
        end
      end

      def initialize(request)
        @request = request
      end

      def response
        FashionFairy::Alexa::Response.new
      end

      private

      def audio(filename)
        %(<audio src="#{ENV['ASSET_HOST']}/audio/#{filename}" />)
      end

      def date_range
        @date_range ||= DateRange.new(date: request.slot('date'))
      end

      def speak(text)
        api.post('/v1/directives', {
          header: {
            requestId: request.id
          },
          directive: {
            type: 'VoicePlayer.Speak',
            speech: %(
              <speak>
                #{text}
              </speak>
            ).squish
          }
        })
      end
    end
  end
end
