module Money
module Model
  class Dollars
    include Comparable
    
    def self.zero
      Dollars.new 0
    end

    def initialize(balance)
      @amount = balance.to_f
    end

    def to_s
      "$#{amount.round}"
    end

    def +(other)
      Dollars.new(amount + other.amount)
    end

    def -(other)
      Dollars.new(amount - other.amount)
    end

    def percentage_of(other)
      return 0 if other == Dollars.zero
      amount / other.amount
    end

    def at_rate(rate)
      Dollars.new(amount * rate)
    end

    def <=>(other)
      amount <=> other.amount
    end

    protected
    attr_reader :amount
  end
end
end
