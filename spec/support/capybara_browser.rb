# frozen_string_literal: true

require 'capybara'
require 'capybara/rspec'
require 'selenium/webdriver'
require 'webdrivers'

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
  # Use the default :selenium (Firefox) browser if no browser
  # is specified
  return (Capybara.default_driver = :selenium) unless browser

  capy_browser = browser.to_sym
  register_browser capy_browser
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
  options = Selenium::WebDriver.const_get(browser).const_get('Options').new
  options.headless! if headless?
  options
end

def headless?
  headless = ENV['HEADLESS']
  return false if headless.nil?

  headless.to_s.downcase != 'false'
end

### MAIN ###
## Set Browser ##
if ENV['REMOTE']
  create_remote_browser(ENV['REMOTE'], ENV['BROWSER'])
else
  create_local_browser(ENV['BROWSER'])
end
