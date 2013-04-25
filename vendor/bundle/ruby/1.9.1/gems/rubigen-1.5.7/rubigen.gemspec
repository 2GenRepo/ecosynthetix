# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{rubigen}
  s.version = "1.5.7"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = [%q{Dr Nic Williams}, %q{Jeremy Kemper}, %q{Ben Klang}]
  s.date = %q{2011-12-31}
  s.description = %q{A framework to allow Ruby applications to generate file/folder stubs 
(like the `rails` command does for Ruby on Rails, and the 'script/generate'
command within a Rails application during development).}
  s.email = [%q{drnicwilliams@gmail.com}, %q{jeremy@bitsweat.net}, %q{bklang@mojolingo.com}]
  s.executables = [%q{install_rubigen_scripts}, %q{rubigen}, %q{ruby_app}]
  s.extra_rdoc_files = [%q{History.txt}, %q{License.txt}, %q{Manifest.txt}, %q{Todo.txt}, %q{app_generators/ruby_app/templates/README.txt}, %q{website/index.txt}, %q{website/version-raw.txt}, %q{website/version.txt}]
  s.files = [%q{.autotest}, %q{History.txt}, %q{License.txt}, %q{Manifest.txt}, %q{README.rdoc}, %q{Rakefile}, %q{Todo.txt}, %q{app_generators/ruby_app/USAGE}, %q{app_generators/ruby_app/ruby_app_generator.rb}, %q{app_generators/ruby_app/templates/README.txt}, %q{app_generators/ruby_app/templates/Rakefile}, %q{app_generators/ruby_app/templates/lib/module.rb}, %q{app_generators/ruby_app/templates/test/test_helper.rb.erb}, %q{bin/install_rubigen_scripts}, %q{bin/rubigen}, %q{bin/ruby_app}, %q{config/website.yml}, %q{features/development.feature}, %q{features/help.feature}, %q{features/rubigen_cli.feature}, %q{features/step_definitions/common_steps.rb}, %q{features/support/common.rb}, %q{features/support/env.rb}, %q{features/support/matchers.rb}, %q{generators/install_rubigen_scripts/install_rubigen_scripts_generator.rb}, %q{generators/install_rubigen_scripts/templates/script/destroy}, %q{generators/install_rubigen_scripts/templates/script/generate}, %q{generators/install_rubigen_scripts/templates/script/win_script.cmd}, %q{lib/rubigen.rb}, %q{lib/rubigen/base.rb}, %q{lib/rubigen/cli.rb}, %q{lib/rubigen/commands.rb}, %q{lib/rubigen/generated_attribute.rb}, %q{lib/rubigen/helpers/generator_test_helper.rb}, %q{lib/rubigen/lookup.rb}, %q{lib/rubigen/manifest.rb}, %q{lib/rubigen/options.rb}, %q{lib/rubigen/scripts.rb}, %q{lib/rubigen/scripts/destroy.rb}, %q{lib/rubigen/scripts/generate.rb}, %q{lib/rubigen/scripts/update.rb}, %q{lib/rubigen/simple_logger.rb}, %q{lib/rubigen/spec.rb}, %q{rubigen.gemspec}, %q{rubygems_generators/application_generator/USAGE}, %q{rubygems_generators/application_generator/application_generator_generator.rb}, %q{rubygems_generators/application_generator/templates/bin}, %q{rubygems_generators/application_generator/templates/generator.rb}, %q{rubygems_generators/application_generator/templates/readme}, %q{rubygems_generators/application_generator/templates/test.rb}, %q{rubygems_generators/application_generator/templates/test_generator_helper.rb}, %q{rubygems_generators/application_generator/templates/usage}, %q{rubygems_generators/component_generator/USAGE}, %q{rubygems_generators/component_generator/component_generator_generator.rb}, %q{rubygems_generators/component_generator/templates/generator.rb}, %q{rubygems_generators/component_generator/templates/rails_generator.rb}, %q{rubygems_generators/component_generator/templates/readme}, %q{rubygems_generators/component_generator/templates/test.rb}, %q{rubygems_generators/component_generator/templates/test_generator_helper.rb}, %q{rubygems_generators/component_generator/templates/usage}, %q{script/console}, %q{script/destroy}, %q{script/generate}, %q{script/txt2html}, %q{test/test_application_generator_generator.rb}, %q{test/test_component_generator_generator.rb}, %q{test/test_generate_builtin_application.rb}, %q{test/test_generate_builtin_test_unit.rb}, %q{test/test_generator_helper.rb}, %q{test/test_helper.rb}, %q{test/test_install_rubigen_scripts_generator.rb}, %q{test/test_lookup.rb}, %q{test/test_rubigen_cli.rb}, %q{test_unit_generators/test_unit/USAGE}, %q{test_unit_generators/test_unit/templates/test.rb}, %q{test_unit_generators/test_unit/test_unit_generator.rb}, %q{website/index.html}, %q{website/index.txt}, %q{website/javascripts/rounded_corners_lite.inc.js}, %q{website/stylesheets/screen.css}, %q{website/template.js}, %q{website/template.rhtml}, %q{website/version-raw.js}, %q{website/version-raw.txt}, %q{website/version.js}, %q{website/version.txt}, %q{.gemtest}]
  s.homepage = %q{http://drnic.github.com/rubigen}
  s.rdoc_options = [%q{--main}, %q{README.rdoc}]
  s.require_paths = [%q{lib}]
  s.rubyforge_project = %q{rubigen}
  s.rubygems_version = %q{1.8.6}
  s.summary = %q{A framework to allow Ruby applications to generate file/folder stubs  (like the `rails` command does for Ruby on Rails, and the 'script/generate' command within a Rails application during development).}
  s.test_files = [%q{test/test_application_generator_generator.rb}, %q{test/test_component_generator_generator.rb}, %q{test/test_generate_builtin_application.rb}, %q{test/test_generate_builtin_test_unit.rb}, %q{test/test_generator_helper.rb}, %q{test/test_helper.rb}, %q{test/test_install_rubigen_scripts_generator.rb}, %q{test/test_lookup.rb}, %q{test/test_rubigen_cli.rb}]

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
