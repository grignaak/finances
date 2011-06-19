module Money
module Model
  class Allowance
    attr_reader :amount, :percentage
    
    def initialize(budget)
      @budget = budget
      self.amount = Dollars.new(0)
    end

    def percentage=(percentage)
      @percentage = percentage
      @amount = @budget.at_rate percentage / 100.0
    end

    def amount=(amount)
      @amount = amount
      @percentage =  100.0 * amount.percentage_of(@amount)
    end
  end
end
end

