# frozen_string_literal: true

require 'capybara'
require 'capybara/poltergeist'
require 'capybara/rspec'
require 'selenium/webdriver'
require 'site_prism'
require 'webdrivers'

# Capybara has pre-registered drivers for chrome and firefox but
# there is a name mapping
# See capybara/registrations/drivers.rb
CHROME_FIREFOX_TO_REGISTERED_CAPYBARA = Hash[
  'firefox': :selenium,
  'firefox_headless': :selenium_headless,
  'chrome': :selenium_chrome,
  'chrome_headless': :selenium_chrome_headless,
  'phantomjs': :poltergeist
]

### METHODS ###
def create_remote_browser(remote_url, browser)
  Capybara.register_driver :remote_browser do |app|
    driver_options = { browser: :remote, url: remote_url }.tap do |opts|
      opts[:capabilities] = browser_options browser
    end
    Capybara::Selenium::Driver.new(app, **driver_options)
  end
  Capybara.default_driver = :remote_browser
end

def create_local_browser(browser)
  capy_browser = (browser || :selenium).to_sym
  capy_browser = CHROME_FIREFOX_TO_REGISTERED_CAPYBARA[capy_browser] || capy_browser
  register_browser capy_browser unless capybara_registered_browser? capy_browser
  Capybara.default_driver = capy_browser
end

def register_browser(browser)
  Capybara.register_driver browser do |app|
    driver_options = { browser: browser, timeout: 30 }.tap do |opts|
      opts[:capabilities] = browser_options browser
    end
    Capybara::Selenium::Driver.new(app, **driver_options)
  end
end

def browser_options(browser)
  browser = browser.to_s.gsub(/\W/, '').capitalize
  # e.g. Selenium::WebDriver::Chrome::Options.new
  Selenium::WebDriver.const_get(browser).const_get('Options').new
end

def capybara_registered_browser?(browser)
  CHROME_FIREFOX_TO_REGISTERED_CAPYBARA.flatten.include?(browser)
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
