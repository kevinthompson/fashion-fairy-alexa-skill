require_relative 'date_range'

module FashionFairy
  module Alexa
    class Intent
      attr_reader :request

      delegate :api, :location, :permission_granted?, to: :request

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

      def permission_required_response
        FashionFairy::Alexa::Response.new(
          text: %(
            #{audio('appear.mp3')}
            Hi, I'm the fashion fairy.
            Before I can recommend an outfit, you'll need to give me permission
            to see your zip code in the Alexa app.
            #{audio('disappear.mp3')}
          )
        )
      end

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
