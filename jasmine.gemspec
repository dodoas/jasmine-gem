# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "jasmine/version"
require "jasmine/ruby_versions"

Gem::Specification.new do |s|
  s.name               = %q{jasmine}
  s.version            = Jasmine::VERSION
  s.platform           = Gem::Platform::RUBY
  s.required_ruby_version = '>= 2.3'

  s.authors            = ["Gregg Van Hove"]
  s.summary            = %q{JavaScript BDD framework}
  s.description        = <<~DESC
    Test your JavaScript without any framework dependencies, in any environment,
    and with a nice descriptive syntax.

    Jasmine for Ruby is deprecated. We recommend using the
    jasmine-browser-runner NPM package instead. It supports all the same
    scenarios as this gem plus Webpacker. See
    https://jasmine.github.io/setup/browser.html for setup instructions, and
    https://github.com/jasmine/jasmine-gem/blob/main/release_notes/3.9.0.md
    for other options.
  DESC
  s.email              = %q{jasmine-js@googlegroups.com}
  s.homepage           = "http://jasmine.github.io/"
  s.license            = "MIT"

  s.files              = `git ls-files`.split("\n") | Dir.glob('jasmine/**/*')
  s.test_files         = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables        = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  s.require_paths      = ["lib"]
  s.rdoc_options       = ["--charset=UTF-8"]

  case ENV['RAILS_VERSION']
  when 'pojs'
  when 'rails4'
    s.add_development_dependency 'rails', '>= 4.2', '< 5.0.0'
  when 'rails5'
    s.add_development_dependency 'rails', '>= 5', '< 6.0.0'
  else #default to rails 6 - keep in sync with `rails_version` in spec_helper
    s.add_development_dependency 'rails', '>= 6', '< 7.0.0'
  end

  s.add_development_dependency 'rack-test'
  s.add_development_dependency 'multi_json'
  s.add_development_dependency 'rspec', '>= 2.5.0'
  s.add_development_dependency 'nokogiri'

  s.add_dependency 'jasmine-core', '3.99.0'
  s.add_dependency 'rack', '>= 2.1.4'
  s.add_dependency 'rake'
end
