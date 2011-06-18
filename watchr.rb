require 'spec/growl'

watch('^spec/(.*)\.rb') { |md| spec md[0] unless md[1] == 'spec_helper' }
watch('^spec/spec_helper\.rb') {|md| spec all_tests } 

watch('^src/.*\.rb') { |md| spec all_tests }

Signal.trap('INT') { exit } #Ctrl-C

def spec(*paths)
  unless jruby "rspec --require spec/spec_helper.rb -fs", paths
     Growl.new nil, {:status => :dead, :message => 'Compile error'}
  end
end

def jruby(cmd, paths)
  system "jruby -I.:src -S #{cmd} --color #{ paths.flatten.join(' ') }"
end

def all_tests
  Dir['spec/**/*_spec.rb']
end

def run(cmd)
  puts   cmd
  output = `#{cmd}`
  puts output
  output
end

