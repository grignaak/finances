module Money
module Model
  class Section
    attr_reader :sub_items

    def initialize()
      @sub_items = []
    end

    def <<(sub_category)
      @sub_items << sub_category
    end

    def [](index)
      @sub_items[index]
    end

    def balance
      sub_items.inject(Dollars.new(0)) do |total, category|
        total + category.balance
      end
    end
  end 
end
end
