class Growl
  attr_accessor :report, :status
  
  def initialize(report, opts = {})
    @report, options = report, create_options(opts)
    @status = options.delete :status
    message = options.delete(:message) || create_message
    
    opts = options.map do |key, value|
      value = value[@status] || value[:default] if value.is_a? Hash
      ["--#{key}", value]
    end

    notifier = [`which growlnotify`, 'true'].map(&:chomp).reject(&:empty?).shift
    opts.unshift("-w -n RSpec")
    Thread.fork {system %(#{notifier} #{opts.join(' ')} -m \"#{message}\")}
  end
  
  private
  
  def create_message
    examples = @report.instance_variable_get(:@example_count).to_i
    failures = @report.instance_variable_get(:@failure_count).to_i
    pendings = @report.instance_variable_get(:@pending_count).to_i
    duration = @report.instance_variable_get(:@duration)
    if failures > 0
        @status = :fail
    elsif pendings > 0
        @status = :pending
    else
        @status = :pass
    end
    "#{examples} Examples - #{failures} Failures - #{pendings} Pending"
  end
  
  def create_options(opts)
    {:title => {
       :pass => 'Pass',
       :fail => 'Fail',
       :dead => 'Fail',
       :pending => 'Pending',
       :default => 'Test Results', },
     :image => {
       :pass => '.growl/green',
       :default => '.growl/red',
       :pending => '.growl/yellow',
       :dead => '.growl/grey', },
     :priority => {
       :default => 0,
       :fail => 2,
       :dead => 2, }
    }.merge(opts)
  end
end


