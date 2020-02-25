# frozen_string_literal: true

require 'capybara'
require 'capybara/poltergeist'
require 'capybara/rspec'
require 'selenium/webdriver'
require 'site_prism'
require 'webdrivers'

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

def register_configure_remote_container_driver(base:, remote_url: 'http://localhost:4444/wd/hub')
  Capybara.register_driver :remote_container_driver do |app|
    Capybara::Selenium::Driver.new(
      app,
      browser: :remote,
      desired_capabilities: base,
      # See https://github.com/SeleniumHQ/docker-selenium on why url setting
      url: remote_url
    )
  end
  Capybara.default_driver = :remote_container_driver
  Capybara.javascript_driver = :remote_container_driver
  Capybara.default_max_wait_time = 15
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

def register_firefox_headless(name)
  Capybara.register_driver name do |app|
    # Set the headless as options args - "borrowed" this from the capybara project tests
    headless_options = ::Selenium::WebDriver::Firefox::Options.new
    headless_options.args << '--headless'

    Capybara::Selenium::Driver.new app,
                                   browser: :firefox,
                                   options: headless_options
  end
end

### MAIN ###

## Set Browser ##
# Set the specific browser from environment variable or not (default is :selenium)
# This uses some selenium/webdriver "inside baseball", specifically that
# :selenium_chrome, :selenium_chrome_headless, and :poltergeist is already registered
# and how to register Firefox as headless
# TODO Look into somehow refactoring this as pass thru ish?

case ENV['SPEC_BROWSER']
when 'chrome'
  configure_driver(:selenium_chrome)

when 'chrome_headless', 'headless_chrome'
  configure_driver(:selenium_chrome_headless)

when 'chrome_container'
  register_configure_remote_container_driver(base: :chrome)

when 'firefox_container'
  register_configure_remote_container_driver(base: :firefox)

when 'firefox'
  register_standard_browser(:firefox)
  configure_driver(:firefox)

when 'firefox_headless', 'headless_firefox'
  register_firefox_headless(:firefox_headless)
  configure_driver(:firefox_headless)

when 'phantomjs'
  configure_driver(:poltergeist)

when 'safari'
  register_standard_browser(:safari)
  configure_safari

else
  if ENV['SPEC_BROWSER']
    # ASSUME remote chrome container address
    remote_hostname = ENV['SPEC_BROWSER']
    warn ">> USING REMOTE DRIVER HOSTNAME: '#{remote_hostname}'  <<"
    remote_url = "http://#{remote_hostname}:4444/wd/hub"
    register_configure_remote_container_driver(base: :chrome, remote_url: remote_url)

  else
    warn '>> USING DEFAULT DRIVER (:selenium) <<'
    configure_driver(:selenium)
  end

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
