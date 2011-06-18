require 'growl'

RSpec.configuration.after :suite do
    Growl.new(Rspec.configuration.reporter)
end
