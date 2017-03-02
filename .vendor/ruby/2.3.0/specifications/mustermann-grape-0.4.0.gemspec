# -*- encoding: utf-8 -*-
# stub: mustermann-grape 0.4.0 ruby lib

Gem::Specification.new do |s|
  s.name = "mustermann-grape"
  s.version = "0.4.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["namusyaka", "Konstantin Haase"]
  s.date = "2016-07-28"
  s.description = "Adds Grape style patterns to Mustermman"
  s.email = "namusyaka@gmail.com"
  s.homepage = "https://github.com/rkh/mustermann"
  s.licenses = ["MIT"]
  s.required_ruby_version = Gem::Requirement.new(">= 2.1.0")
  s.rubygems_version = "2.5.1"
  s.summary = "Grape syntax for Mustermann"

  s.installed_by_version = "2.5.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<mustermann>, ["= 0.4.0"])
    else
      s.add_dependency(%q<mustermann>, ["= 0.4.0"])
    end
  else
    s.add_dependency(%q<mustermann>, ["= 0.4.0"])
  end
end
