require 'extras/accessors'
require 'money/model/allowance'
require 'money/model/dollars'
require 'money/model/section'

module Money::Model
  class Contribution
    attr_accessor :balance
    def initialize(balance)
      @balance = balance
    end
  end

  class Category
    extend Extras::Accessors

    attr_reader :allowance
    attr_reader!(:expenses) { Section.new }
    attr_reader!(:contributions) { Section.new }
    attr_accessor! :carry_over, Dollars.new(0)

    def initialize(budget)
      @allowance = Allowance.new(budget)
    end
    
    def end_balance
      carry_over.balance \
      + allowance.amount \
      + contributions.balance \
      - expenses.balance
    end

    def contribute_to(category, amount)
      contribution = Contribution.new amount
      expenses << contribution
      category.contributions << contribution
    end

    def inspect
        {:allowance => allowance,
         :expenses => expenses,
         :contributions => contributions,
         :carry_over => carry_over,
        }.inspect 
    end
  end
end
