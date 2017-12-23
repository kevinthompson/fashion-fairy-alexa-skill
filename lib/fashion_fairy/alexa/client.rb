require 'httparty'

module FashionFairy
  module Alexa
    class Client
      include HTTParty

      attr_reader :access_token, :endpoint

      def initialize(access_token:, endpoint:)
        @access_token = access_token
        @endpoint = endpoint
      end

      def get(path, body = {})
        request(:get, path, body)
      end

      def post(path, body = {})
        request(:post, path, body)
      end

      private

      def request(type, path, body)
        self.class.send(type, "#{endpoint}#{path}", {
          headers: headers,
          body: body.to_json
        })
      end

      def headers
        {
          'Content-Type' => 'application/json',
          'Authorization' => "Bearer #{access_token}"
        }
      end
    end
  end
end
