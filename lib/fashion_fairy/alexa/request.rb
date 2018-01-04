require 'active_support/all'
require 'alexa_verifier'
require 'json'
require_relative 'client'
require_relative 'intent'
require_relative '../location'
Dir.glob(File.expand_path('intent/*', File.dirname(__FILE__))) { |file| require file }

module FashionFairy
  module Alexa
    class Request
      include

      INTENT_REQUEST_TYPE = 'IntentRequest'.freeze
      SLOT_SUCCESS_MATCH = 'ER_SUCCESS_MATCH'.freeze

      def initialize(request)
        @request = request
      end

      def id
        data.dig('request', 'requestId')
      end

      def response
        if permission_granted?
          if location_available?
            scoped_to_time_zone(location.time_zone) do
              intent.response
            end
          else
            FashionFairy::Alexa::Response.new(
              text: %(
                I'm sorry, but I can't seem to figure out where you're at.
                If you try again in a little bit I might be able to find you.
              )
            )
          end
        else
          FashionFairy::Alexa::Response.new(
            text: %(
              Before I can find your zip code, you'll need to grant me
              permission in your Alexa app.
            ),
            card: {
              type: "AskForPermissionsConsent",
              permissions: [
                "read::alexa:device:all:address"
              ]
            }
          )
        end
      end

      def location
        FashionFairy::Location.from_zip_code(zip_code)
      end

      def session(key)
        data.dig('session', 'attributes', key)
      end

      def slot(key)
        if slot = data.dig('request', 'intent', 'slots', key)
          if resolutions = slot.dig('resolutions', 'resolutionsPerAuthority')
            if resolutions.first.dig('status', 'code') == SLOT_SUCCESS_MATCH
              resolutions.first['values'].first.dig('value', 'name')
            end
          else
            slot.dig('value')
          end
        end
      end

      def api
        @api ||= FashionFairy::Alexa::Client.new(
          access_token: access_token,
          endpoint: endpoint
        )
      end

      def valid?
        AlexaVerifier.valid!(request) && application_id == ENV['ALEXA_SKILL_ID']
      end

      private

      def permission_granted?
        endpoint && access_token && zip_code
      rescue
        false
      end

      def location_available?
        location.present?
      rescue
        false
      end

      attr_reader :request

      def data
        @data ||= JSON.parse(request.body.read)
      end

      def access_token
        data.dig('context', 'System', 'apiAccessToken')
      end

      def endpoint
        data.dig('context', 'System', 'apiEndpoint')
      end

      def zip_code
        @zip_code ||= begin
          response = api.get("/v1/devices/#{device_id}/settings/address/countryAndPostalCode")
          response.success? && JSON.parse(response.body)['postalCode']
        end
      end

      def application_id
        data.dig('session', 'application', 'applicationId')
      end

      def device_id
        data.dig('context', 'System', 'device', 'deviceId')
      end

      def intent
        (intent_class || FashionFairy::Alexa::Intent::NullIntent).new(self)
      end

      def intent_name
        if data.dig('request', 'type') == INTENT_REQUEST_TYPE
          data.dig('request', 'intent', 'name')
        else
          data.dig('request', 'type')
        end
      end

      def intent_class
        intent_class_name = intent_name[/\w+$/]
        intent_class_name << 'Intent' unless intent_class_name[/Intent$/]
        FashionFairy::Alexa::Intent.find(intent_class_name)
      end

      def scoped_to_time_zone(time_zone, &block)
        previous_time_zone = Time.zone
        Time.zone = location.time_zone
        yield.tap do
          Time.zone = previous_time_zone
        end
      end
    end
  end
end
