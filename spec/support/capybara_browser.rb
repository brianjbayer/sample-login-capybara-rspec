# frozen_string_literal: true

require 'capybara'
require 'capybara/rspec'
require 'selenium/webdriver'

require_relative 'config'

### METHODS ###
# Main method that determines and creates the Capybara-driven browser
def create_browser
  # default is local default capybara browser
  return Capybara.default_driver = :selenium unless browser || url

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

  # Handle any custom browser options here
  options = custom_chrome_options if browser == 'Chrome'

  # Otherwise use the browser name to dynamically create the options
  # e.g. Selenium::WebDriver::Firefox::Options.new
  options ||= Selenium::WebDriver.const_get(browser).const_get('Options').new

  options.add_argument('--headless') if headless?
  options
end

def custom_chrome_options
  Selenium::WebDriver::Options.chrome.tap do |options|
    # Prevents popup "Change Your Password - The password you just used was found in a data breach."
    options.add_preference('profile.password_manager_leak_detection', false)
  end
end

def browser
  # e.g. :chrome
  Config::Capybara.browser&.to_sym
end

def url
  Config::Capybara.remote_browser_url
end

def headless?
  Config::Capybara.headless?
end

### MAIN ###
create_browser
