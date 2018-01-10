require 'newrelic_rpm'
require 'pry'
require 'sinatra/base'
require 'uri'
require_relative 'request'

module FashionFairy
  module Alexa
    class Server < Sinatra::Base
      set :static, true
      set :public_folder, Proc.new { File.join(File.dirname(__FILE__), '../../../public') }

      post '/' do
        if alexa_request.valid?
          alexa_request.response.to_json
        else
          halt 403
        end
      end

      def alexa_request
        @alexa_request ||= FashionFairy::Alexa::Request.new(request)
      end

      run! if __FILE__ == $0
    end
  end
end
