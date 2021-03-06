# -*- encoding: utf-8 -*-
# stub: tool 0.2.3 ruby lib

Gem::Specification.new do |s|
  s.name = "tool"
  s.version = "0.2.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Konstantin Haase"]
  s.date = "2014-11-25"
  s.description = "general purpose Ruby library used by Sinatra 2.0, Mustermann and related projects"
  s.email = "konstantin.mailinglists@googlemail.com"
  s.extra_rdoc_files = ["README.md"]
  s.files = ["README.md"]
  s.homepage = "https://github.com/rkh/tool"
  s.licenses = ["MIT"]
  s.required_ruby_version = Gem::Requirement.new(">= 2.0.0")
  s.rubygems_version = "2.5.1"
  s.summary = "general purpose library"

  s.installed_by_version = "2.5.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>, ["~> 3.0.0.beta"])
      s.add_development_dependency(%q<simplecov>, [">= 0"])
      s.add_development_dependency(%q<coveralls>, [">= 0"])
      s.add_development_dependency(%q<rake>, [">= 0"])
    else
      s.add_dependency(%q<rspec>, ["~> 3.0.0.beta"])
      s.add_dependency(%q<simplecov>, [">= 0"])
      s.add_dependency(%q<coveralls>, [">= 0"])
      s.add_dependency(%q<rake>, [">= 0"])
    end
  else
    s.add_dependency(%q<rspec>, ["~> 3.0.0.beta"])
    s.add_dependency(%q<simplecov>, [">= 0"])
    s.add_dependency(%q<coveralls>, [">= 0"])
    s.add_dependency(%q<rake>, [">= 0"])
  end
end
