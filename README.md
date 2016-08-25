# MY LOGIN CAPYBARA RSPEC PROJECT

This is a simple sample project demonstrating a simple login feature 
and verifying the critical elements on the login page.

##Requirements:

Install Chrome if you don't already have it.

Install ChromeDriver if you don't already have it.

Install a Ruby version manager (tests run with Ruby 2.2.0). 

Install phantomJS, use version 1.9.8 and move to ```/usr/local/bin```:

http://phantomjs.org/download.html

To download version 1.9.8 for mac OS X: https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-1.9.8-macosx.zip

To download version 1.9.8 for Windows: https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-1.9.8-windows.zip

Install bundler (if not already installed for your Ruby):

```
$ gem install bundler
```

Install gems (from project root):

```
$ bundle
```

To run tests in the browser (Chrome):
```
$ bundle exec rspec
```

To run tests with PhantomJS:

```
$ HEADLESS=true bundle exec rspec
```

These are Capybara/rspec tests which use the SitePrism page object gem: [SitePrism docs](http://www.rubydoc.info/gems/site_prism/index), [SitePrism on github](https://github.com/natritmeyer/site_prism)