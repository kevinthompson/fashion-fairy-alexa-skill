require_relative 'date_range'

module FashionFairy
  module Alexa
    class Intent
      attr_reader :request

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

      private

      def api
        request.api
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
            speech: text
          }
        })
      end
    end
  end
end
