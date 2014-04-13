require "jtask/version"

Gem::Specification.new do |s|
  s.name        = "jtask"
  s.version     = JTask::VERSION
  s.date        = JTask::RELEASE_DATE
  s.platform    = Gem::Platform::RUBY
  s.description = "Provides CRUD actions for JSON files, plus a few extra goodies."
  s.summary     = "CRUD actions for JSON files."
  s.homepage    = "https://github.com/adammcarthur/jtask"
  s.license     = "MIT"

  s.authors     = ["Adam McArthur"]
  s.email       = ["adam@adammcarthur.net"]

  s.files         = `git ls-files`.split($/)
  s.test_files    = s.files.grep(%r{^(spec)/})
  s.require_paths = ["lib"]

  s.required_ruby_version = ">= 1.9.3"

  s.add_runtime_dependency "json", "~> 1.4"
  s.add_development_dependency "rspec", "~> 2"
  s.post_install_message = "\n- - -\nThanks for installing JTask Beta. Please be aware that this release is not considered stable and is in no way production-ready. JTask v1.0.0 (expected arrival > 1 month) will mark the first stable release of this gem.\n - Adam\n- - -\n"
end
