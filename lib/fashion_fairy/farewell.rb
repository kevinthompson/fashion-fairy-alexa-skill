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
      ]
    end
  end
end
