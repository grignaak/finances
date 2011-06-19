require 'extras/accessors'
require 'money/model/allowance'

module Money::Model
  class Category
    extend Extras::Accessors

    attr_reader :allowance
    attr_reader!(:expenses) { Section.new }
    attr_reader!(:contributions) { Section.new }
    attr_accessor! :carry_over, 0

    def initialize(budget)
      @allowance = Allowance.new(budget)
    end
    
    def end_balance
      (allowance.amount + carry_over + contributions.balance) - expenses.balance
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
