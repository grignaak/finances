watch('^spec/spec_helper\.rb') {|md| spec all_tests } 
watch('^spec/(.*)\.rb') { |md| spec md[0] unless md[1] == 'spec_helper' }

watch('^src/.*\.rb') { |md| spec all_tests }

Signal.trap('INT') { exit } #Ctrl-C

def spec(*paths)
  jruby "rspec --require spec/spec_helper.rb -fs", paths
end

def jruby(cmd, paths)
  run "jruby -I.:src -S #{cmd} --color #{ paths.flatten.join(' ') }"
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

