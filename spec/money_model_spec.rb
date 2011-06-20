require 'money_model'

module Money::Model

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
