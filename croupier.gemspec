# encoding: utf-8

Gem::Specification.new do |s|
  s.name = 'croupier'
  s.version = "0.0.1"
  s.platform = Gem::Platform::RUBY
  s.date = Time.now.strftime('%Y-%m-%d')
  
  s.summary = "Samples of numbers with specific probability distributions" 
  s.description = "Croupier is a Ruby gem to generate a random sample of numbers with a given probability distribution."
  
  s.authors = ['Juanjo Bazán']
  s.email = ["jjbazan@gmail.com"]
  s.homepage = 'https://github.com/xuanxu/croupier'
  
  s.has_rdoc = true
  s.rdoc_options = ['--main', 'README.rdoc', '--charset=UTF-8']
  
  s.files = %w(MIT-LICENSE.txt README.rdoc) + Dir.glob("{spec,lib/**/*}") & `git ls-files -z`.split("\0")
  s.test_files = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  
  s.add_development_dependency("rspec", ">=2.8.0")
end