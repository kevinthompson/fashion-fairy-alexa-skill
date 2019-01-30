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

      def scoped_to_time_zone(time_zone, &block)
        previous_time_zone = Time.zone
        Time.zone = location.time_zone
        yield.tap do
          Time.zone = previous_time_zone
        end
      end

      def permission_required_response
        FashionFairy::Alexa::Response.new(
          text: %(
            #{begin_sound}
            Hi, I'm the fashion fairy.
            Before I can recommend an outfit, you'll need to give me permission
            to see your zip code in the Alexa app.
            #{end_sound}
          )
        )
      end

      def begin_sound
        audio('appear.mp3')
      end

      def end_sound
        audio('disappear.mp3')
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
                <prosody pitch="high">
                  #{text}
                </prosody>
              </speak>
            ).squish
          }
        })
      end
    end
  end
end
