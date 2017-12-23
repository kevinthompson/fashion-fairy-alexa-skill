require 'pry'
require 'redis'
require 'sinatra/base'
require_relative 'request'

module FashionFairy
  module Alexa
    class Server < Sinatra::Base
      configure do
        uri = URI.parse(ENV["REDISCLOUD_URL"])
        $redis = Redis.new(
          host: uri.host,
          port: uri.port,
          password: uri.password
        )
      end

      post '/' do
        alexa_request = FashionFairy::Alexa::Request.new(request)
        alexa_request.response.to_json
      end

      run! if __FILE__ == $0
    end
  end
end
