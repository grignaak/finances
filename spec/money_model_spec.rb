require 'money_model'
require 'test/unit'

module Money
module Model

describe Dollars do
  it "should display the balance" do
    Dollars.new(200).balance.should == 200
  end

  it "should accept a yearly income" do
    Dollars.new(1200, :per => :year).balance.should == 100
  end
end

describe Section do
  it "should accept a sub-item" do
    c = Section.new 
    c << Dollars.new(0)
    c.sub_items.length.should == 1
  end

  it "should keep a balance" do
    c = Section.new
    c.balance.should == 0
  end

  it "should keep a balance of its sub-items" do
    c = Section.new
    c << Dollars.new(100)
    c.balance.should == 100
  end
end

describe Budget do
  it "should have income, needs, wants, savings sections" do
    app = Budget.new
    app.income.should_not be_nil
    app.wants.should_not be_nil
    app.savings.should_not be_nil
    app.needs.should_not be_nil
  end
end


describe Category do
  Dollars = Dollars
  
  describe Allowance do
    it "should be expressible as percentage of the whole" do
      c = Category.new Dollars.new(1000)
      c.allowance.percentage = 20

      c.allowance.amount.should == 200
    end

    it "should be expressible as an amount" do
      c = Category.new Dollars.new(1000)
      c.allowance.amount = 200

      c.allowance.percentage = 20
    end
  end

  it "should have a list of balances" do
    c = Category.new Dollars.new(1000)
    c << Dollars.new(10)
    c << Dollars.new(20)

    c.balance.should == 30
  end
end


end
end
