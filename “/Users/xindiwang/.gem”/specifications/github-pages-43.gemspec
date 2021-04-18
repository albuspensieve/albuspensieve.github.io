# -*- encoding: utf-8 -*-
# stub: github-pages 43 ruby lib

Gem::Specification.new do |s|
  s.name = "github-pages".freeze
  s.version = "43"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["GitHub, Inc.".freeze]
  s.date = "2016-01-15"
  s.description = "Bootstrap the GitHub Pages Jekyll environment locally.".freeze
  s.email = "support@github.com".freeze
  s.executables = ["github-pages".freeze]
  s.files = ["bin/github-pages".freeze]
  s.homepage = "https://github.com/github/pages-gem".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.0.0".freeze)
  s.rubygems_version = "3.1.4".freeze
  s.summary = "Track GitHub Pages dependencies.".freeze

  s.installed_by_version = "3.1.4" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<jekyll>.freeze, ["= 2.4.0"])
    s.add_runtime_dependency(%q<jekyll-coffeescript>.freeze, ["= 1.0.1"])
    s.add_runtime_dependency(%q<jekyll-sass-converter>.freeze, ["= 1.3.0"])
    s.add_runtime_dependency(%q<kramdown>.freeze, ["= 1.9.0"])
    s.add_runtime_dependency(%q<maruku>.freeze, ["= 0.7.0"])
    s.add_runtime_dependency(%q<rdiscount>.freeze, ["= 2.1.8"])
    s.add_runtime_dependency(%q<redcarpet>.freeze, ["= 3.3.3"])
    s.add_runtime_dependency(%q<RedCloth>.freeze, ["= 4.2.9"])
    s.add_runtime_dependency(%q<liquid>.freeze, ["= 2.6.2"])
    s.add_runtime_dependency(%q<pygments.rb>.freeze, ["= 0.6.3"])
    s.add_runtime_dependency(%q<jemoji>.freeze, ["= 0.5.0"])
    s.add_runtime_dependency(%q<jekyll-mentions>.freeze, ["= 0.2.1"])
    s.add_runtime_dependency(%q<jekyll-redirect-from>.freeze, ["= 0.9.1"])
    s.add_runtime_dependency(%q<jekyll-sitemap>.freeze, ["= 0.9.0"])
    s.add_runtime_dependency(%q<jekyll-feed>.freeze, ["= 0.3.1"])
    s.add_runtime_dependency(%q<jekyll-gist>.freeze, ["= 1.4.0"])
    s.add_runtime_dependency(%q<jekyll-paginate>.freeze, ["= 1.1.0"])
    s.add_runtime_dependency(%q<github-pages-health-check>.freeze, ["= 0.6.0"])
    s.add_runtime_dependency(%q<jekyll-seo-tag>.freeze, ["= 0.1.4"])
    s.add_runtime_dependency(%q<mercenary>.freeze, ["~> 0.3"])
    s.add_runtime_dependency(%q<terminal-table>.freeze, ["~> 1.4"])
    s.add_development_dependency(%q<rspec>.freeze, ["~> 3.3"])
  else
    s.add_dependency(%q<jekyll>.freeze, ["= 2.4.0"])
    s.add_dependency(%q<jekyll-coffeescript>.freeze, ["= 1.0.1"])
    s.add_dependency(%q<jekyll-sass-converter>.freeze, ["= 1.3.0"])
    s.add_dependency(%q<kramdown>.freeze, ["= 1.9.0"])
    s.add_dependency(%q<maruku>.freeze, ["= 0.7.0"])
    s.add_dependency(%q<rdiscount>.freeze, ["= 2.1.8"])
    s.add_dependency(%q<redcarpet>.freeze, ["= 3.3.3"])
    s.add_dependency(%q<RedCloth>.freeze, ["= 4.2.9"])
    s.add_dependency(%q<liquid>.freeze, ["= 2.6.2"])
    s.add_dependency(%q<pygments.rb>.freeze, ["= 0.6.3"])
    s.add_dependency(%q<jemoji>.freeze, ["= 0.5.0"])
    s.add_dependency(%q<jekyll-mentions>.freeze, ["= 0.2.1"])
    s.add_dependency(%q<jekyll-redirect-from>.freeze, ["= 0.9.1"])
    s.add_dependency(%q<jekyll-sitemap>.freeze, ["= 0.9.0"])
    s.add_dependency(%q<jekyll-feed>.freeze, ["= 0.3.1"])
    s.add_dependency(%q<jekyll-gist>.freeze, ["= 1.4.0"])
    s.add_dependency(%q<jekyll-paginate>.freeze, ["= 1.1.0"])
    s.add_dependency(%q<github-pages-health-check>.freeze, ["= 0.6.0"])
    s.add_dependency(%q<jekyll-seo-tag>.freeze, ["= 0.1.4"])
    s.add_dependency(%q<mercenary>.freeze, ["~> 0.3"])
    s.add_dependency(%q<terminal-table>.freeze, ["~> 1.4"])
    s.add_dependency(%q<rspec>.freeze, ["~> 3.3"])
  end
end
