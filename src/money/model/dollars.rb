module Money
module Model
  class Dollars
    attr_reader :balance

    def initialize(balance, opts = {})
      balance /= 12 if opts[:per] == :year
      @balance = balance
    end
  end
end
end
