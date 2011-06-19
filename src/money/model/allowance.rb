module Money
module Model
  class Allowance
    attr_reader :amount, :percentage
    
    def initialize(budget)
      @budget = budget
      self.amount = 0
    end

    def percentage=(percentage)
      @percentage = percentage
      @amount = (percentage / 100.0) * budget
    end

    def amount=(amount)
      @amount = amount
      @percentage =  (100.0 * amount) / budget
    end

    def budget
      @budget.balance
    end
  end
end
end

