# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "sorted"
  s.version = "0.4.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.3.6") if s.respond_to? :required_rubygems_version=
  s.authors = ["Rufus Post"]
  s.date = "2012-06-03"
  s.description = "lets you sort large data sets using view helpers and a scope"
  s.email = ["rufuspost@gmail.com"]
  s.homepage = "http://rubygems.org/gems/sorted"
  s.require_paths = ["lib"]
  s.rubyforge_project = "sorted"
  s.rubygems_version = "1.8.11"
  s.summary = "sort data with a database"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<bundler>, [">= 1.0.0"])
      s.add_development_dependency(%q<rails>, [">= 3.1.2"])
      s.add_development_dependency(%q<rspec>, [">= 2.0.0"])
      s.add_development_dependency(%q<sqlite3>, [">= 1.3.5"])
    else
      s.add_dependency(%q<bundler>, [">= 1.0.0"])
      s.add_dependency(%q<rails>, [">= 3.1.2"])
      s.add_dependency(%q<rspec>, [">= 2.0.0"])
      s.add_dependency(%q<sqlite3>, [">= 1.3.5"])
    end
  else
    s.add_dependency(%q<bundler>, [">= 1.0.0"])
    s.add_dependency(%q<rails>, [">= 3.1.2"])
    s.add_dependency(%q<rspec>, [">= 2.0.0"])
    s.add_dependency(%q<sqlite3>, [">= 1.3.5"])
  end
end
