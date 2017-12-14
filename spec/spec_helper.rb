require 'capybara'
require 'capybara/rspec'
require 'site_prism'
require 'capybara/poltergeist'
require 'selenium/webdriver'

### METHODS ###
def register_vanilla_browser(selenium_browser_name)
  puts "register_vanilla_browser(#{selenium_browser_name})"
  Capybara.register_driver selenium_browser_name do |app|
    Capybara::Selenium::Driver.new(app, browser: selenium_browser_name)
  end
  selenium_browser_name
end

def configure_driver(registered_driver)
  # Assumption: registered_driver supports javascript and non-rack
  Capybara.configure do |c|
    c.default_driver        = registered_driver
    c.run_server            = false
    c.default_max_wait_time = 15
  end
end

### MAIN ###
# Set the specific browser from environment variable or not (default is :selenium)
# This uses some selenium/webdriver "inside baseball", specifically that
# :selenium_chrome, :selenium_chrome_headless, and :poltergeist is already registered
case ENV['SPEC_BROWSER']

when 'chrome'
  configure_driver(:selenium_chrome)

when 'chrome_headless', 'headless_chrome'
  configure_driver(:selenium_chrome_headless)

when 'firefox'
  register_vanilla_browser(:firefox)
  configure_driver(:firefox)

when 'phantomjs'
  configure_driver(:poltergeist)

when 'safari'
  register_vanilla_browser(:safari)
  configure_driver(:safari)

else
  STDERR.puts '>> USING DEFAULT DRIVER (:selenium) <<'
  configure_driver(:selenium)
end

# Configure Page Object
SitePrism.configure do |config|
  config.use_implicit_waits = true
end

# Configure Test Framework
RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
end
