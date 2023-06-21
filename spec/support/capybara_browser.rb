# frozen_string_literal: true

require 'capybara'
require 'capybara/rspec'
require 'selenium/webdriver'
require 'webdrivers'

### METHODS ###
def create_browser(browser:, url:)
  # default is local default capybara browser
  return (Capybara.default_driver = :selenium) unless browser || url

  browser = browser.to_sym
  options = browser_options(browser)

  Capybara.register_driver :capy_browser do |app|
    Capybara::Selenium::Driver.new(app,
                                   # For remote, browser: must be :remote
                                   browser: url ? :remote : browser,
                                   options:, url:)
  end
  Capybara.default_driver = :capy_browser
end

def browser_options(browser)
  browser = browser.to_s.gsub(/\W/, '').capitalize
  # e.g. Selenium::WebDriver::Chrome::Options.new
  options = Selenium::WebDriver.const_get(browser).const_get('Options').new
  options.add_argument('--headless') if headless_specified?
  options
end

def headless_specified?
  headless = ENV.fetch('HEADLESS', false)
  headless.to_s.downcase != 'false'
end

### MAIN ###
create_browser(browser: ENV.fetch('BROWSER', nil),
               url: ENV.fetch('REMOTE', nil))
