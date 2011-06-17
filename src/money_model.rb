module Money
module Model

  class Category
    attr_reader :sub_items

    def initialize()
      @sub_items = []
    end

    def <<(sub_category)
      @sub_items << sub_category
    end

    def balance
      sub_items.inject(0) do |total, category|
        total + category.balance
      end
    end
  end 

  class Principle
    def self.asset(*args)
      new(*args)
    end

    def self.liability(balance, *rest)
      new(-balance, *rest)
    end

    attr_reader :balance

    def initialize(balance, opts = {})
      balance /= 12 if opts[:per] == :year
      @balance = balance
    end
  end

  class Tax
    def initialize(percent, principle)
      @percent = percent
      @principle = principle
    end

    def balance
      @principle.balance * (@percent / 100.0)
    end
  end

end
end
