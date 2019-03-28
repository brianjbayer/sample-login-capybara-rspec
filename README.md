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
* support for selenium standalone containers

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
* `chrome` - Google Chrome (requires Chrome and installs chromedriver)
* `chrome_headless` - Google Chrome run in headless mode (requires Chrome > 59 and installs chromedriver)
* `chrome_container` - runs against the remote Selenium Standalone Chrome Debug container (requires this container
to be already running on the default ports)
* `firefox` - Mozilla Firefox (requires Firefox and installs geckodriver)
* `firefox_headless` - Mozilla Firefox run in headless mode (requires Firefox and installs geckodriver)
* `firefox_container` - runs against the remote Selenium Standalone Firefox Debug container (requires this container
to be already running on the default ports)
* `phantomjs` - PhantomJS headless browser (installs PhantomJS)
* `safari` - Apple Safari (requires Safari)

## To Run Using the Selenium Standalone Debug Containers
These tests can be run using the Selenium Standalone Debug containers for both
Chrome and Firefox.  These *debug* containers run a VNC server that allow you to see
the tests running in the browser in that container.  These Selenium Standalone Debug containers
must be running on the default port of `4444`.

For more information on these Selenium Standalone Debug containers see https://github.com/SeleniumHQ/docker-selenium.

### Prerequisites
You must have docker installed and running on your local machine.

To use the VNC server, you must have a VNC client on your local machine (e.g. Screen Sharing application on Mac).

### To Run Using Selenium Standalone Chrome Debug Container
1. Ensure Docker is running on your local machine
2. Run the Selenium Standalone Chrome Debug container on the default ports of 4444 and 5900 
for the VNC server  
`docker run -d -p 4444:4444 -p 5900:5900 -v /dev/shm:/dev/shm selenium/standalone-chrome-debug:latest`
3. Wait for the Selenium Standalone Chrome Debug container to be running (e.g. 'docker ps')
4. Run the tests using the `chrome_container`  
`SPEC_BROWSER=chrome_container bundle exec rspec`

### To Run Using Selenium Standalone Firefox Debug Container
1. Ensure Docker is running on your local machine
2. Run the Selenium Standalone Firefox Debug container on the default ports of 4444 and 5900 
for the VNC server  
`docker run -d -p 4444:4444 -p 5900:5900 -v /dev/shm:/dev/shm selenium/standalone-firefox-debug:latest`
3. Wait for the Selenium Standalone Firefox Debug container to be running (e.g. 'docker ps')
4. Run the tests using the `firefox_container`  
`SPEC_BROWSER=firefox_container bundle exec rspec`

### To See the Tests Run Using the VNC Server
1. Connect to vnc://localhost:5900 (On Mac you can simply enter this address into a Browser)

## Requirements
* Tests run with Ruby 2.4.5. 
* To run the tests using a specific **local** browser requires that browser 
be installed - NOTE: chromedriver, geckodriver, and phantomjs will be
installed with the gems).

Install bundler (if not already installed for your Ruby):

```
$ gem install bundler
```

Install gems (from project root):

```
$ bundle
```

## Additional Information
These tests use the... 
  * SitePrism page object gem: [SitePrism docs](http://www.rubydoc.info/gems/site_prism/index), [SitePrism on github](https://github.com/natritmeyer/site_prism)
  * Webdrivers browser driver helper gem: [Webdrivers on github](https://github.com/titusfortner/webdrivers)
  * phantomjs-helper phantomjs driver helper gem: [phantomjs-helper on
    github](https://github.com/bergholdt/phantomjs-helper)
