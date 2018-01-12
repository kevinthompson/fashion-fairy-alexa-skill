module FashionFairy
  module Alexa
    class Response
      attr_reader :card, :directives, :should_end_session, :text

      def initialize(card: nil, directives: nil, should_end_session: true, text: nil)
        @card = card
        @directives = Array(directives)
        @should_end_session = should_end_session
        @text = text
      end

      def as_hash
        {
          response: {
            output_speech: text ? output_speech : nil,
            directives: directives.map(&:as_hash),
            card: card&.as_hash,
            should_end_session: should_end_session
          }
        }
      end

      def to_json
        map_keys(as_hash).to_json
      end

      private

      def map_keys(obj)
        if obj.is_a? Array
          obj.map { |o| map_keys(o) }
        elsif obj.is_a? Hash
          obj.each_with_object({}) do |(key, value), hash|
            unless Array(value).empty?
              hash[key.to_s.gsub(/_(\w)/){ $1.upcase }] = map_keys(value)
            end
          end
        else
          obj
        end
      end

      def output_speech
        {
          ssml: %(
            <speak>
              <prosody pitch="high">
                #{text}
              </prosody>
            </speak>
          ).squish,
          type: 'SSML'
        }
      end
    end
  end
end
