module Money
module Model
  class Entry
    attr_accessor :total
    def initialize(amount)
      @total = amount
    end
  end

  class Section
    def self.singleton(amount)
      Entry.new amount
    end

    def initialize()
      @entries = []
    end

    def items
      @entries.length
    end

    def <<(sub_category)
      @entries << sub_category
    end

    def [](index)
      @entries[index]
    end

    def total
      @entries.inject(Dollars.new(0)) do |total, category|
        total + category.total
      end
    end
  end 
end
end
