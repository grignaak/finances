module Money
module Model
  class Section
    attr_reader :sub_items
    attr_reader :allowance

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
end
end
