require 'money_model'
require 'test/unit'

module Money
module Model

describe Principle do
  it "should accept a yearly income" do
    Principle.asset(1200, :per => :year).balance.should == 100
  end

  it "should accept a monthly outflow" do
    Principle.liability(100).balance.should == -100
  end
end

describe Section do
  it "should accept a sub-item" do
    c = Section.new 
    c << Principle.asset(0)
    c.sub_items.length.should == 1
  end

  it "should keep a balance" do
    c = Section.new
    c.balance.should == 0
  end

  it "should keep a balance of its sub-items" do
    c = Section.new
    c << Principle.asset(100)
    c.balance.should == 100
  end
end


describe Tax do
  it "should take a percentage off it's argument" do
    tax = Tax.new 10, Principle.asset(1000)
    tax.balance.should == 100
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

  it "should have the balance of income-wants-savings-needs" do
    app = Budget.new
    app.income << Principle.asset(1000)
    app.wants << Principle.asset(10)
    app.savings << Principle.asset(20)
    app.needs << Principle.asset(30)

    app.balance.should == 940
  end
end

end
end
