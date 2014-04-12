Gem::Specification.new do |s|
  s.name        = 'jtask'
  s.version     = '0.3.0'
  s.platform    = Gem::Platform::RUBY
  s.date        = '2014-04-03'
  s.description = "Provides CRUD actions for JSON files, plus a few extra goodies."
  s.summary     = "CRUD actions for JSON files."
  s.authors     = ["Adam McArthur"]
  s.email       = 'adam@adammcarthur.net'
  s.homepage    = 'https://github.com/adammcarthur/jtask'
  s.license     = 'MIT'
  s.files       = `git ls-files`.split($/)
  s.require_paths = ["lib"]
  s.add_runtime_dependency "json", "~> 1.4"
  s.add_development_dependency "rspec", "~> 2"
  s.post_install_message = "\nThanks for installing JTask Beta. Check out the full documentation and contribute at https://github.com/adammcarthur/jtask\n\nIn this release (v0.3.0 Beta): https://github.com/adammcarthur/jtask/releases/tag/v0.3.0\n\n- Adam (@adammcarth)\n-"
end
