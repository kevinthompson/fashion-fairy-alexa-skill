module FashionFairy
  class Greeting
    attr_reader :location

    def initialize(location:)
      @location = location
    end

    def to_s
      "Good Morning!"
    end
  end
end
