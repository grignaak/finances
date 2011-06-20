require 'money/model/section'
require 'money/model/dollars'

module Money::Model

describe Section do

  describe 'Entry' do
    subject { Entry.new Dollars.new(100) }
    it "should have a balance" do
      subject.total.should == Dollars.new(100)
    end
  end

  describe 'multiline section' do
    subject { Section.new }

    it "should accept a sub-item" do
      subject << Section.singleton(Dollars.zero)
      subject.items.should == 1
    end

    it "should keep a balance" do
      subject.total.should == Dollars.zero
    end

    it "should keep a balance of its sub-items" do
      subject << Entry.new(Dollars.new(100))
      subject.total.should == Dollars.new(100)
    end
  end
end

end
