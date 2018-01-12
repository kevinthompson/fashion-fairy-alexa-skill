module FashionFairy
  class Farewell
    def to_s
      farewells.sample
    end

    private

    def farewells
      [
        %(Have a great day!),
        %(<say-as interpret-as="interjection">Deuces!</say-as>),
        %(Fashion Fairy out!),
        %(Ta ta for now!),
        %(Have a fabulous day!),
      ]
    end
  end
end
