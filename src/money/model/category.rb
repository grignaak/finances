require 'extras/accessors'
require 'money/model/allowance'

module Money::Model
  class Category
    extend Extras::Accessors

    attr_reader :allowance
    attr_reader! :balances, Section.new

    def initialize(budget)
      @allowance = Allowance.new(budget)
    end
    
    def percent_of_whole
      return (1.0 * balance) / @allowance.budget
    end

    def <<(item)
      balances << item
    end

    def balance
      balances.balance
    end

  end

end
