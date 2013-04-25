# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "pdf-stamper"
  s.version = "0.3.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Jason Yates"]
  s.date = "2009-02-07"
  s.description = "Super cool PDF templates using iText's PdfStamper.  == CAVEAT:  Anything super cool must have a caveat. You have to use JRuby or RJB. Plus you can only use Adobe LiveCycle Designer to create the templates.  == EXAMPLE: pdf = PDF::Stamper.new(\"my_template.pdf\") pdf.text :first_name, \"Jason\" pdf.text :last_name, \"Yates\" pdf.image :photo, \"photo.jpg\" pdf.save_as \"my_output.pdf\""
  s.email = "jaywhy@gmail.com"
  s.extra_rdoc_files = ["History.txt", "Manifest.txt", "README.txt"]
  s.files = ["History.txt", "Manifest.txt", "README.txt"]
  s.homepage = "  http://github.com/jaywhy/pdf-stamper/"
  s.rdoc_options = ["--main", "README.txt"]
  s.require_paths = ["lib", "ext"]
  s.rubyforge_project = "pdf-stamper"
  s.rubygems_version = "1.8.11"
  s.summary = "Super cool PDF templates using iText's PdfStamper."

  if s.respond_to? :specification_version then
    s.specification_version = 2

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<newgem>, [">= 1.2.3"])
      s.add_development_dependency(%q<hoe>, [">= 1.8.0"])
    else
      s.add_dependency(%q<newgem>, [">= 1.2.3"])
      s.add_dependency(%q<hoe>, [">= 1.8.0"])
    end
  else
    s.add_dependency(%q<newgem>, [">= 1.2.3"])
    s.add_dependency(%q<hoe>, [">= 1.8.0"])
  end
end
