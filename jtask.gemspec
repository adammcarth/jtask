Gem::Specification.new do |s|
  s.name        = 'jtask'
  s.version     = '0.0.1'
  s.platform    = Gem::Platform::RUBY
  s.date        = '2014-03-23'
  s.description = "Provides CRUD actions for JSON files, plus a few extra goodies."
  s.summary     = "CRUD actions for JSON files."
  s.authors     = ["Adam McArthur"]
  s.email       = 'adam@adammcarthur.net'
  s.homepage    = 'https://github.com/adammcarthur/jtask'
  s.license     = 'MIT'
  s.files       = `git ls-files`.split($/)
  s.require_paths = ["lib"]
  s.add_runtime_dependency "json", "~> 1.4"
  s.post_install_message = "\nThanks for installing JTask Beta. Check out the full documentation and contribute at https://github.com/adammcarthur/jtask\n\n- Adam (@adammcarth)\n-"
end
