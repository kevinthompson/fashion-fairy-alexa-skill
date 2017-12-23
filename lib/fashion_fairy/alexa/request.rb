require 'active_support/all'
require 'colorize'
require 'json'
require_relative 'client'
require_relative 'intent'
Dir.glob(File.expand_path('intent/*', File.dirname(__FILE__))) { |file| require file }

module FashionFairy
  module Alexa
    class Request
      include

      INTENT_REQUEST_TYPE = 'IntentRequest'.freeze
      SLOT_SUCCESS_MATCH = 'ER_SUCCESS_MATCH'.freeze

      def initialize(request)
        @request = JSON.parse(request.body.read)
        log_request
      end

      def id
        request.dig('request', 'requestId')
      end

      def response
        intent.response
      end

      def session(key)
        request.dig('session', 'attributes', key)
      end

      def slot(key)
        if slot = request.dig('request', 'intent', 'slots', key)
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
          access_token: request.dig('context', 'System', 'apiAccessToken'),
          endpoint: request.dig('context', 'System', 'apiEndpoint')
        )
      end

      private

      attr_reader :request

      def intent
        (intent_class || FashionFairy::Alexa::Intent::NullIntent).new(self)
      end

      def log_request
        slots = request.dig('request', 'intent', 'slots')
        error = request.dig('request', 'error')
        color = error ? 'red' : 'green'

        print "\n"
        print '  Intent Received '.black.send("on_#{color}")
        print "\n"
        print "  Intent: "
        print intent_name.send(color)
        print "\n"

        if error
          print "  Error:  "
          print error['type']
          print "\n"
          print "          #{error['message']}"
        else
          print "  Class:  "
          print intent.class.name.yellow
        end
        print "\n"

        if request.dig('request', 'dialogState')
          print "  Dialog: "
          print request.dig('request', 'dialogState').green
          print "\n"
        end

        if slots
          print "  Slots:\n"
          slots.keys.each do |key|
            print "    #{slots.dig(key, 'name')}: "

            if slot(key)
              print slot(key).green
            else
              print 'nil'.blue
            end

            print "\n"
          end
        end

        print "\n"
      end

      def intent_name
        if request.dig('request', 'type') == INTENT_REQUEST_TYPE
          request.dig('request', 'intent', 'name')
        else
          request.dig('request', 'type')
        end
      end

      def intent_class
        intent_class_name = intent_name[/\w+$/]
        intent_class_name << 'Intent' unless intent_class_name[/Intent$/]
        FashionFairy::Alexa::Intent.find(intent_class_name)
      end
    end
  end
end
