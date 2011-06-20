require 'money/model/category'
require 'money/model/dollars'
require 'money/model/allowance'

module Money::Model

describe Category do
  MockBudget = Dollars
  def new_category
    Category.new MockBudget.new(1000) 
  end
  subject { new_category }
  
  describe 'Category Allowance' do
    it "should be expressible as percentage of the whole" do
      subject.allowance.percentage = 20
      subject.allowance.amount.should == Dollars.new(200)
    end

    it "should be expressible as an amount" do
      subject.allowance.amount = Dollars.new(200)
      subject.allowance.percentage = 20
    end
  end
  
  it "should have an allowance" do
    subject.allowance.percentage = 20
  end

  it "should have a carry-over balance" do
    subject.carry_over = Dollars.new(100)
    subject.carry_over.should == Dollars.new(100)
  end

  it "should have a list of contributions" do
    subject.contributions << Section.singleton(Dollars.new(10))
    subject.contributions << Section.singleton(Dollars.new(40))
    subject.contributions.total.should == Dollars.new(50)
  end

  it "should have a list of expenses" do
    subject.expenses << Section.singleton(Dollars.new(10))
    subject.expenses << Section.singleton(Dollars.new(20))
    subject.expenses.total.should == Dollars.new(30)
  end

  it "should have an end balance" do
    subject.allowance.amount = Dollars.new(1000)
    subject.carry_over = Dollars.new(100)
    subject.contributions << Entry.new(Dollars.new(10))
    subject.expenses << Section.singleton(Dollars.new(1111))
    subject.end_balance.should == Dollars.new(-1)
  end

  describe 'contributions' do
    before(:each) do
      @c = new_category
      subject.contribute_to @c, Dollars.new(100)
      @contribution = @c.contributions[0]
    end

    it "should contribute to another category" do
      subject.end_balance.should == Dollars.new(-100)
      @c.end_balance.should == Dollars.new(100)
    end

    it "should be reflect updates in both source and destination" do
      @contribution.total = Dollars.new(200)
      
      @c.end_balance.should == Dollars.new(200)
      subject.end_balance.should == Dollars.new(-200)
    end

    xit "should be removed from source when removed from destination" do
      @c.contributions.remove contribution

      subject.end_balance.should == Dollars.new(0)
    end

    xit "should be removed from destination when removed from source" do
      subject.expenses.remove @contribution

      subject.end_balance.should == Dollars.new(0)

    end
  end
end

end
