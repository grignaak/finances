require 'money_model'

module Money::Model

describe Section do
  subject { Section.new }
  it "should accept a sub-item" do
    subject << Dollars.zero
    subject.sub_items.length.should == 1
  end

  it "should keep a balance" do
    subject.balance.should == Dollars.zero
  end

  it "should keep a balance of its sub-items" do
    subject << Dollars.new(100)
    subject.balance.should == Dollars.new(100)
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

end
