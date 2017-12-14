require 'capybara'
require 'capybara/rspec'
require 'site_prism'
require 'capybara/poltergeist'
require 'selenium/webdriver'

### METHODS ###
def register_standard_browser(selenium_browser_name)
  Capybara.register_driver selenium_browser_name do |app|
    Capybara::Selenium::Driver.new(app, browser: selenium_browser_name)
  end
end

def configure_driver(registered_driver)
  # Assumption: registered_driver supports javascript and non-rack
  Capybara.configure do |c|
    c.javascript_driver     = registered_driver
    c.default_driver        = registered_driver
    c.run_server            = false
    c.default_max_wait_time = 15
  end
end

def configure_safari
  # Safari can NOT be set as the default browser - the choice here is arbitrary
  Capybara.configure do |c|
    c.javascript_driver     = :safari
    c.default_driver        = :selenium_chrome_headless
    c.run_server            = false
    c.default_max_wait_time = 15
  end
  Capybara.current_driver = :safari
end

### MAIN ###

## Set Browser ##
# Set the specific browser from environment variable or not (default is :selenium)
# This uses some selenium/webdriver "inside baseball", specifically that
# :selenium_chrome, :selenium_chrome_headless, and :poltergeist is already registered
case ENV['SPEC_BROWSER']

when 'chrome'
  configure_driver(:selenium_chrome)

when 'chrome_headless', 'headless_chrome'
  configure_driver(:selenium_chrome_headless)

when 'firefox'
  register_standard_browser(:firefox)
  configure_driver(:firefox)

when 'phantomjs'
  configure_driver(:poltergeist)

when 'safari'
  register_standard_browser(:safari)
  configure_safari

else
  STDERR.puts '>> USING DEFAULT DRIVER (:selenium) <<'
  configure_driver(:selenium)
end

## Configure Page Object ##
SitePrism.configure do |config|
  config.use_implicit_waits = true
end

## Configure Test Framework ##
RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
end
