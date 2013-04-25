# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "rubigen"
  s.version = "1.5.7"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Dr Nic Williams", "Jeremy Kemper", "Ben Klang"]
  s.date = "2011-12-31"
  s.description = "A framework to allow Ruby applications to generate file/folder stubs \n(like the `rails` command does for Ruby on Rails, and the 'script/generate'\ncommand within a Rails application during development)."
  s.email = ["drnicwilliams@gmail.com", "jeremy@bitsweat.net", "bklang@mojolingo.com"]
  s.executables = ["install_rubigen_scripts", "rubigen", "ruby_app"]
  s.extra_rdoc_files = ["History.txt", "License.txt", "Manifest.txt", "Todo.txt", "app_generators/ruby_app/templates/README.txt", "website/index.txt", "website/version-raw.txt", "website/version.txt"]
  s.files = ["bin/install_rubigen_scripts", "bin/rubigen", "bin/ruby_app", "History.txt", "License.txt", "Manifest.txt", "Todo.txt", "app_generators/ruby_app/templates/README.txt", "website/index.txt", "website/version-raw.txt", "website/version.txt"]
  s.homepage = "http://drnic.github.com/rubigen"
  s.rdoc_options = ["--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubyforge_project = "rubigen"
  s.rubygems_version = "1.8.11"
  s.summary = "A framework to allow Ruby applications to generate file/folder stubs  (like the `rails` command does for Ruby on Rails, and the 'script/generate' command within a Rails application during development)."

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activesupport>, [">= 2.3.5"])
      s.add_runtime_dependency(%q<i18n>, [">= 0"])
      s.add_development_dependency(%q<rspec>, ["~> 1.3"])
      s.add_development_dependency(%q<mocha>, [">= 0.9.8"])
      s.add_development_dependency(%q<cucumber>, [">= 0.6.2"])
      s.add_development_dependency(%q<shoulda>, [">= 2.10.3"])
      s.add_development_dependency(%q<hoe>, [">= 0"])
      s.add_development_dependency(%q<hoe-git>, [">= 0"])
      s.add_development_dependency(%q<newgem>, [">= 0"])
      s.add_development_dependency(%q<rdoc>, ["~> 3.10"])
      s.add_development_dependency(%q<hoe>, ["~> 2.12"])
    else
      s.add_dependency(%q<activesupport>, [">= 2.3.5"])
      s.add_dependency(%q<i18n>, [">= 0"])
      s.add_dependency(%q<rspec>, ["~> 1.3"])
      s.add_dependency(%q<mocha>, [">= 0.9.8"])
      s.add_dependency(%q<cucumber>, [">= 0.6.2"])
      s.add_dependency(%q<shoulda>, [">= 2.10.3"])
      s.add_dependency(%q<hoe>, [">= 0"])
      s.add_dependency(%q<hoe-git>, [">= 0"])
      s.add_dependency(%q<newgem>, [">= 0"])
      s.add_dependency(%q<rdoc>, ["~> 3.10"])
      s.add_dependency(%q<hoe>, ["~> 2.12"])
    end
  else
    s.add_dependency(%q<activesupport>, [">= 2.3.5"])
    s.add_dependency(%q<i18n>, [">= 0"])
    s.add_dependency(%q<rspec>, ["~> 1.3"])
    s.add_dependency(%q<mocha>, [">= 0.9.8"])
    s.add_dependency(%q<cucumber>, [">= 0.6.2"])
    s.add_dependency(%q<shoulda>, [">= 2.10.3"])
    s.add_dependency(%q<hoe>, [">= 0"])
    s.add_dependency(%q<hoe-git>, [">= 0"])
    s.add_dependency(%q<newgem>, [">= 0"])
    s.add_dependency(%q<rdoc>, ["~> 3.10"])
    s.add_dependency(%q<hoe>, ["~> 2.12"])
  end
end
