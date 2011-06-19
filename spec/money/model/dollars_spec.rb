require 'money/model/dollars'

module Money::Model

describe Dollars do
  describe 'when compared' do
    it "should equal another one" do
      Dollars.new(1200).should == Dollars.new(1200)
    end

    it "should be comparable" do
      (Dollars.zero.is_a? Comparable).should == true
      (Dollars.new(1) <=> Dollars.new(1)).should == 0
    end

    it "should round up when showing the amount with 50 pennies" do
      Dollars.new(1.50).to_s.should == "$2"
    end

    it "should round when showing the amount with < 50 pennies" do
      Dollars.new(1.49).to_s.should == "$1"
    end
  end
  it "should handle addition" do
    (Dollars.new(1200) + Dollars.new(12)).should == Dollars.new(1212)
  end

  it "should keep the pennies when adding" do
    (Dollars.new(1.50) + Dollars.new(3.50)).should == Dollars.new(5.00)
  end

  it "should handle subtraction" do
    (Dollars.new(1100) - Dollars.new(100)).should == Dollars.new(1000)
  end

  it "should give the percentage of another" do
    Dollars.new(100).percentage_of(Dollars.new(1000)).should == 0.10
  end

  it "should give 0 as the percentage of 0" do
    Dollars.new(100).percentage_of(Dollars.zero).should == 0
  end

  it "should multiply by a percentage" do
    Dollars.new(1000).at_rate(0.20).should == Dollars.new(200)
  end

  it "should show the dollar amount" do
    Dollars.new(10).to_s.should == "$10"
  end

end

end
