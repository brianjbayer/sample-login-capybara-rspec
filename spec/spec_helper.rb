# frozen_string_literal: true

require 'capybara'
require 'capybara/poltergeist'
require 'capybara/rspec'
require 'selenium/webdriver'
require 'site_prism'
require 'webdrivers'

# Capybara has registered drivers for chrome and firefox but
# there is a mapping
# This is inside baseball from capybara/registrations/drivers.rb
CAPYBARA_RENAME = Hash[
  'firefox': :selenium,
  'firefox_headless': :selenium_headless,
  'chrome': :selenium_chrome,
  'chrome_headless': :selenium_chrome_headless,
  'phantomjs': :poltergeist
]

### METHODS ###
def create_remote_browser(remote_url, browser)
  browser = browser.gsub(/\W/, '').capitalize

  Capybara.register_driver :remote_browser do |app|
    browser_options = Selenium::WebDriver.const_get(browser).const_get('Options').new
    driver_options = { browser: :remote, url: remote_url }.tap do |opts|
      opts[:capabilities] = browser_options
    end
    Capybara::Selenium::Driver.new(app, **driver_options)
  end
  Capybara.default_driver = :remote_browser
end

def create_local_browser(browser)
  # Default local is :selenium (firefox)
  capy_browser = (browser || :selenium).to_sym

  # Do any renaming to registered capybara driver
  capy_browser = CAPYBARA_RENAME[capy_browser] || capy_browser

  # Safari is not a registered capybara driver
  register_safari if capy_browser.eql? :safari

  # Assume valid pass-thru registered capybara driver
  Capybara.default_driver = capy_browser
end

def register_safari
  Capybara.register_driver :safari do |app|
    browser_options = ::Selenium::WebDriver::Safari::Options.new
    driver_options = { browser: :safari, timeout: 30 }.tap do |opts|
      opts[:capabilities] = browser_options
    end
    Capybara::Selenium::Driver.new(app, **driver_options)
  end
end

### MAIN ###
## Set Browser ##
if ENV['REMOTE']
  create_remote_browser(ENV['REMOTE'], ENV['BROWSER'])
else
  create_local_browser(ENV['BROWSER'])
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
