# sample-login-capybara-rspec

## Overview
This is an example 
[Capybara](https://github.com/teamcapybara/capybara)-[RSpec](http://rspec.info/)-[Ruby](https://www.ruby-lang.org)
implementation of Acceptance Test Driven Development (ATDD).
**However, it also provides a somewhat extensible framework that can be reused
by replacing the existing tests.**

These tests show how to use Capybara-RSpec to verify...
* that critical elements are on a page
* the ability to login as a user

It also demonstrates the basic features
of the Capybara-RSpec framework and how they can be extended.
This example contains...
* support for multiple browsers

## To Run the Automated Tests
The tests can be run either directly by the RSpec runner or by the
supplied Rakefile.

### To Run Using Rake
When running the tests using Rake, the tests are run in
parallel **unless** the Safari browser is chosen.

To run the automated tests using Rake, execute...  
*command-line-arguments* `bundle exec rake`

* To run using the default ":selenium", execute...  
`bundle exec rake`

### To Run Using RSpec
When running the tests using RSpec, the tests are run sequentially.

To run the automated tests using RSpec, execute...  
*command-line-arguments* `bundle exec rspec`

* To run using the default ":selenium", execute...  
`bundle exec rspec`

### Command Line Arguments
#### Specify Browser
`SPEC_BROWSER=`...

**Example:**
`SPEC_BROWSER=chrome`

Currently the following browsers are supported in this project:
* `chrome` - Google Chrome (requires Chrome and chromedriver)
* `chrome_headless` - Google Chrome run in headless mode (requires Chrome > 59 and chromedriver)
* `firefox` - Mozilla Firefox (requires Firefox and geckodriver)
* `firefox_headless` - Mozilla Firefox run in headless mode (requires Firefox and geckodriver)
* `phantomjs` - PhantomJS headless browser (requires PhantomJS)
* `safari` - Apple Safari (requires Safari)

## Requirements
* Tests run with Ruby 2.4.0. 
* To run the tests using a specific browser requires that browser 
be installed as well as any required browser driver
(e.g. to run the tests in the Chrome Browser requires
Chrome and chromedriver be installed).

Install bundler (if not already installed for your Ruby):

```
$ gem install bundler
```

Install gems (from project root):

```
$ bundle
```

## Additional Information
These tests use the SitePrism page object gem: [SitePrism docs](http://www.rubydoc.info/gems/site_prism/index), [SitePrism on github](https://github.com/natritmeyer/site_prism)
