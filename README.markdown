# The Jasmine Gem
[![FOSSA Status](https://app.fossa.io/api/projects/git%2Bgithub.com%2Fjasmine%2Fjasmine-gem.svg?type=shield)](https://app.fossa.io/projects/git%2Bgithub.com%2Fjasmine%2Fjasmine-gem?ref=badge_shield)
[![Gem Version](https://badge.fury.io/rb/jasmine.svg)](https://badge.fury.io/rb/jasmine)

The [Jasmine](http://github.com/jasmine/jasmine) Ruby Gem is a package of helper code for developing Jasmine projects for Ruby-based web projects (Rails, Sinatra, etc.) or for JavaScript projects where Ruby is a welcome partner. It serves up a project's Jasmine suite in a browser so you can focus on your code instead of manually editing script tags in the Jasmine runner HTML file.

Webpacker support is provided via the 
[jasmine-browser-runner](https://jasmine.github.io/setup/browser.html#use-with-rails)
NPM package, not this gem. `jasmine-browser-runner` can also be used to test
JavaScript in Rails applications that use the Asset Pipeline.

## Discontinued

The `jasmine` and `jasmine-core` Ruby gems are discontinued. There will be no
further releases. We recommend that most
users migrate to the [jasmine-browser-runner](https://github.com/jasmine/jasmine-browser)
npm package, which is the direct replacement for the `jasmine` gem.

If `jasmine-browser-runner` doesn't meet your needs, one of these might:

* The [jasmine](https://github.com/jasmine/jasmine-npm) npm package to run
  specs in Node.js.
* The [standalone distribution](https://github.com/jasmine/jasmine#installation)
  to run specs in browsers with no additional tools.
* The [jasmine-core](https://github.com/jasmine/jasmine) npm package if all
  you need is the Jasmine assets. This is the direct equivalent of the
  `jasmine-core` Ruby gem.

## Contents
This gem contains:

* A small server that builds and executes a Jasmine suite for a project
* A script that sets up a project to use the Jasmine gem's server
* Generators for Ruby on Rails projects (Rails 4 and 5)

You can get all of this by: `gem install jasmine` or by adding Jasmine to your `Gemfile`.

```ruby
group :development, :test do
  gem 'jasmine'
end
```

## Init A Project

To initialize a rails project for Jasmine

    rails generate jasmine:install

    rails generate jasmine:examples

For any other project (Sinatra, Merb, or something we don't yet know about) use

    jasmine init

    jasmine examples

## Usage

Start the Jasmine server:

    rake jasmine

Point your browser to `localhost:8888`. The suite will run every time this page is re-loaded.

For Continuous Integration environments, add this task to the project build steps:

    rake jasmine:ci

## Configuration

Customize `spec/javascripts/support/jasmine.yml` to enumerate the source files, stylesheets, and spec files you would like the Jasmine runner to include.
You may use dir glob strings.

Alternatively, you may specify the path to your `jasmine.yml` by setting an environment variable:

`rake jasmine:ci JASMINE_CONFIG_PATH=relative/path/to/your/jasmine.yml`

In addition, the `spec_helper` key in your jasmine.yml specifies the path to a ruby file that can do programmatic configuration.
After running `jasmine init` or `rails generate jasmine:install` it will point to `spec/javascripts/support/jasmine_helper.rb` which you can modify to fit your needs.

### Running Jasmine on a different port

The ports that `rake jasmine` (or `rake jasmine:server`) and `rake jasmine:ci` run on are configured independently, so they can both run at the same time.

To change the port that `rake jasmine` uses:

In your jasmine_helper.rb:

```ruby
Jasmine.configure do |config|
  config.server_port = 5555
end
```

By default `rake jasmine:ci` will attempt to find a random open port, to set the port that `rake jasmine:ci` uses:

In your jasmine_helper.rb:

```ruby
Jasmine.configure do |config|
  config.ci_port = 1234
end
```

By default `rake jasmine:ci` will print results in color, to change this configuration:

In your jasmine_helper.rb:

```ruby
Jasmine.configure do |config|
  config.color = false
end
```

## Using headless Chrome

* In your jasmine_helper.rb:
```ruby
Jasmine.configure do |config|
  config.runner_browser = :chromeheadless
end
```

### Additional configuration options

* `config.ferrum_browser_options` - Options passed to Ferrum::Browser.new https://github.com/rubycdp/ferrum#customization

### On Travis-CI

Add this to your `.travis.yml`

```yaml
addons:
  chrome: stable
```

## Support

Documentation: [jasmine.github.io](https://jasmine.github.io)
Jasmine Mailing list: [jasmine-js@googlegroups.com](mailto:jasmine-js@googlegroups.com)
Twitter: [@jasminebdd](http://twitter.com/jasminebdd)

Please file issues here at Github

Copyright (c) 2008-2017 Pivotal Labs. This software is licensed under the MIT License.


## License
[![FOSSA Status](https://app.fossa.io/api/projects/git%2Bgithub.com%2Fjasmine%2Fjasmine-gem.svg?type=large)](https://app.fossa.io/projects/git%2Bgithub.com%2Fjasmine%2Fjasmine-gem?ref=badge_large)
