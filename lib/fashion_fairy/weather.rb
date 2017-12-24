require 'httparty'

module FashionFairy
  class Weather
    include HTTParty
    base_uri 'api.weather.gov'

    attr_reader :location

    def initialize(location:)
      @location = location
    end

    def forecast
      response = self.class.get("/points/#{location.latitude},#{location.longitude}/forecast")
      JSON.parse(response.body)
    end

    def hourly
      response = self.class.get("/points/#{location.latitude},#{location.longitude}/forecast/hourly")
      JSON.parse(response.body)
    end
  end
end
