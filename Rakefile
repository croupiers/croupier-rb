require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = FileList['test/**/test*.rb']
  t.verbose = true
end
task :default => :test

namespace :test do
  task :distributions do
    puts `./generate_test_data.sh`
    puts `cd test && Rscript rtests.R`
  end
end

