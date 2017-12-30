require 'alexa_verifier'
require 'pry'
require 'redis'
require 'sinatra/base'
require_relative 'request'

module FashionFairy
  module Alexa
    class Server < Sinatra::Base
      set :static, true
      set :public_folder, Proc.new { File.join(File.dirname(__FILE__), '../../../public') }

      configure do
        uri = URI.parse(ENV["REDISCLOUD_URL"])
        $redis = Redis.new(
          host: uri.host,
          port: uri.port,
          password: uri.password
        )
      end

      post '/' do
        if AlexaVerifier.valid?(request) && alexa_request.valid?
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
