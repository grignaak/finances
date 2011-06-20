require 'extras/accessors'
require 'money/model/section'
require 'money/model/category'

module Money::Model
  class Budget
    extend Extras::Accessors
    attr_reader! :income, Section.new
    attr_reader! :outflow, Section.new
    [:wants, :needs, :savings].each do |sym|
      attr_reader! sym do Category.new self; end
    end

    def initialize
      [wants, needs, savings].each {|o| outflow << o }
    end
  end
end
