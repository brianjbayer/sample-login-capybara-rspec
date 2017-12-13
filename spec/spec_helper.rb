require 'capybara'
require 'capybara/rspec'
require 'site_prism'
require 'capybara/poltergeist'
require 'selenium/webdriver'

# Register the Selenium Browsers
# chrome
Capybara.register_driver :selenium_chrome do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end

# headless chrome
Capybara.register_driver :selenium_chrome_headless do |app|
  capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
    chromeOptions: { args: %w[headless] }
  )
  Capybara::Selenium::Driver.new app,
                                 browser: :chrome,
                                 desired_capabilities: capabilities
end

# firefox
Capybara.register_driver :selenium_firefox do |app|
  Capybara::Selenium::Driver.new(app, browser: :firefox)
end

# safari
Capybara.register_driver :selenium_safari do |app|
  Capybara::Selenium::Driver.new(app, browser: :safari)
end

# Set the defaults (phantomjs hook)
Capybara.configure do |c|
  c.javascript_driver     = :selenium
  c.default_driver        = :poltergeist
  c.run_server            = false
  c.default_max_wait_time = 15
end

# Set the specific browser from environment variable or not (default is chrome)
case ENV['SPEC_BROWSER']
when 'chrome'
  Capybara.current_driver = :selenium_chrome
when 'chrome_headless'
  Capybara.current_driver = :selenium_chrome_headless
when 'firefox'
  Capybara.current_driver = :selenium_firefox
when 'phantomjs'
  # use the default_driver
  true
when 'safari'
  Capybara.current_driver = :selenium_safari
else
  Capybara.current_driver = :selenium_chrome
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
