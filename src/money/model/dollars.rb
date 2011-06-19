module Money
module Model
  class Dollars
    include Comparable
    
    def balance
      self
    end

    def self.zero
      Dollars.new 0
    end

    def initialize(balance)
      @balance = balance.to_f
    end

    def to_s
      "$#{@balance.round}"
    end

    def +(other)
      Dollars.new(_balance + other._balance)
    end

    def -(other)
      Dollars.new(_balance - other._balance)
    end

    def percentage_of(other)
      return 0 if other == Dollars.zero
      _balance / other._balance
    end

    def at_rate(rate)
      Dollars.new(_balance * rate)
    end

    def <=>(other)
      @balance <=> other._balance
    end

    protected
    def _balance
      @balance
    end
    
  end
end
end
