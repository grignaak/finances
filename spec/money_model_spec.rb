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

describe Category do
  it "should accept a sub-item" do
    c = Category.new 
    c << Principle.asset(0)
    c.sub_items.length.should == 1
  end

  it "should keep a balance" do
    c = Category.new
    c.balance.should == 0
  end

  it "should keep a balance of it's sub-item" do
    c = Category.new
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


end
end
