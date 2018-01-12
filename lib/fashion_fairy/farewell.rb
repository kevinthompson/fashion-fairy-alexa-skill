module FashionFairy
  class Farewell
    def to_s
      farewells.sample
    end

    private

    def farewells
      [
        %(Have a great day!),
        %(Fashion Fairy out!),
        %(Ta ta for now!),
        %(Have a fabulous day!),
        %(See you tomorrow!),
      ]
    end
  end
end
