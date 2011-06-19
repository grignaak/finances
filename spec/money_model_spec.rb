require 'money_model'

module Money::Model

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
  MockBudget = Dollars
  def new_category
    Category.new MockBudget.new(1000) 
  end
  subject { new_category }
  
  describe 'Category Allowance' do
    it "should be expressible as percentage of the whole" do
      subject.allowance.percentage = 20
      subject.allowance.amount.should == 200
    end

    it "should be expressible as an amount" do
      subject.allowance.amount = 200
      subject.allowance.percentage = 20
    end
  end
  
  it "should have an allowance" do
    subject.allowance.percentage = 20
  end

  it "should have a carry-over balance" do
    subject.carry_over = 100
    subject.carry_over.should == 100
  end

  it "should have a list of contributions" do
    subject.contributions << Dollars.new(10)
    subject.contributions << Dollars.new(40)
    subject.contributions.balance.should == 50
  end

  it "should have a list of expenses" do
    subject.expenses << Dollars.new(10)
    subject.expenses << Dollars.new(20)
    subject.expenses.balance.should == 30
  end

  it "should have an end balance" do
    subject.allowance.amount = 1000
    subject.carry_over = 100
    subject.contributions << Dollars.new(10)
    subject.expenses << Dollars.new(1111)
    subject.end_balance.should == -1
  end

  describe 'contributions' do
    it "should contribute to another category" do
      c = new_category
      c.allowance.amount = 1000
      subject.allowance.amount = 1000

      subject.contribute_to c, Dollars.new(100)

      subject.end_balance.should == 900
      c.end_balance.should == 1100
    end

    xit "should be removed from source when removed from destination" do
      c = new_category
    
      subject.contribute_to c, Dollars.new(100)
      contribution = c.contributions[0]

      c.contributions.remove contribution

      subject.end_balance.should == 0
    end

    xit "should be removed from destination when removed from source" do

    end
  end
end

end
