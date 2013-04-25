# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "newgem"
  s.version = "1.5.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Dr Nic Williams"]
  s.date = "2009-08-02"
  s.description = "Quickly bundle any Ruby libraries into a RubyGem and share it with the world, your colleagues, or perhaps just with yourself amongst your projects.\n\nRubyGems are centrally stored, versioned, and support dependencies between other gems, so they are the ultimate way to bundle libraries, executables, associated tests, examples, and more.\n\nWithin this gem, you get one thing - <code>newgem</code> - an executable to create your own gems. Your new gems will include designated folders for Ruby code, test files, executables, and even a default website page for you to explain your project, and which instantly uploads to RubyForge website (which looks just like this one by default)"
  s.email = ["drnicwilliams@gmail.com"]
  s.executables = ["newgem"]
  s.extra_rdoc_files = ["History.txt", "Manifest.txt", "PostInstall.txt", "app_generators/newgem/templates/History.txt", "app_generators/newgem/templates/PostInstall.txt", "newgem_generators/install_website/templates/website/index.txt", "newgem_theme_generators/long_box_theme/templates/website/index.txt", "rubygems_generators/extconf/templates/README.txt", "website/index.txt", "website/rubyforge.txt", "website/version-raw.txt", "website/version.txt"]
  s.files = ["bin/newgem", "History.txt", "Manifest.txt", "PostInstall.txt", "app_generators/newgem/templates/History.txt", "app_generators/newgem/templates/PostInstall.txt", "newgem_generators/install_website/templates/website/index.txt", "newgem_theme_generators/long_box_theme/templates/website/index.txt", "rubygems_generators/extconf/templates/README.txt", "website/index.txt", "website/rubyforge.txt", "website/version-raw.txt", "website/version.txt"]
  s.homepage = "http://newgem.rubyforge.org"
  s.post_install_message = "PostInstall.txt"
  s.rdoc_options = ["--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubyforge_project = "newgem"
  s.rubygems_version = "1.8.11"
  s.summary = "Quickly bundle any Ruby libraries into a RubyGem and share it with the world, your colleagues, or perhaps just with yourself amongst your projects"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activesupport>, [">= 2.0.2"])
      s.add_runtime_dependency(%q<rubigen>, [">= 1.5.2"])
      s.add_runtime_dependency(%q<hoe>, [">= 2.3.1"])
      s.add_runtime_dependency(%q<RedCloth>, [">= 4.1.1"])
      s.add_runtime_dependency(%q<syntax>, [">= 1.0.0"])
      s.add_development_dependency(%q<cucumber>, [">= 0.3.11"])
      s.add_development_dependency(%q<hoe>, [">= 2.3.1"])
    else
      s.add_dependency(%q<activesupport>, [">= 2.0.2"])
      s.add_dependency(%q<rubigen>, [">= 1.5.2"])
      s.add_dependency(%q<hoe>, [">= 2.3.1"])
      s.add_dependency(%q<RedCloth>, [">= 4.1.1"])
      s.add_dependency(%q<syntax>, [">= 1.0.0"])
      s.add_dependency(%q<cucumber>, [">= 0.3.11"])
      s.add_dependency(%q<hoe>, [">= 2.3.1"])
    end
  else
    s.add_dependency(%q<activesupport>, [">= 2.0.2"])
    s.add_dependency(%q<rubigen>, [">= 1.5.2"])
    s.add_dependency(%q<hoe>, [">= 2.3.1"])
    s.add_dependency(%q<RedCloth>, [">= 4.1.1"])
    s.add_dependency(%q<syntax>, [">= 1.0.0"])
    s.add_dependency(%q<cucumber>, [">= 0.3.11"])
    s.add_dependency(%q<hoe>, [">= 2.3.1"])
  end
end
