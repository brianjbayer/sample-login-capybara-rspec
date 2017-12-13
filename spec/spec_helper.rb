require 'capybara'
require 'capybara/rspec'
require 'site_prism'
require 'capybara/poltergeist'
require "selenium/webdriver"


# Register the Selenium Browsers
# chrome
Capybara.register_driver :selenium_chrome do |app|
    Capybara::Selenium::Driver.new(app, :browser => :chrome)
end

# headless chrome
Capybara.register_driver :selenium_chrome_headless do |app|
  capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
      chromeOptions: { args: %w(headless) }
  )

  Capybara::Selenium::Driver.new app,
                                 browser: :chrome,
                                 desired_capabilities: capabilities
end

# firefox
Capybara.register_driver :selenium_firefox do |app|
  Capybara::Selenium::Driver.new(app, :browser => :firefox)
end

# phantomjs
Capybara.register_driver :selenium_phantomjs do |app|
  Capybara::Selenium::Driver.new(app, :browser => :phantomjs)
end

# firefox
Capybara.register_driver :selenium_safari do |app|
  Capybara::Selenium::Driver.new(app, :browser => :safari)
end

# Set the defaults
Capybara.configure do |c|
  c.javascript_driver = :selenium
  c.default_driver    = :poltergeist
#  c.default_driver    = :selenium_chrome if ENV['HEADLESS'].nil?
  c.run_server        = false
  c.default_max_wait_time = 15
end

# Set the specific browser from environment variable (or not)
case ENV['SPEC_BROWSER']
  when 'chrome'
    Capybara.current_driver = :selenium_chrome
  when 'chrome_headless'
    puts "!!CHROME HEADLESS!!!"
    Capybara.current_driver = :selenium_chrome_headless
  when 'firefox'
    Capybara.current_driver = :selenium_firefox
  when 'phantomjs'
    puts "!!!PHANTOMJS - USE DEFAULT DRIVER!!!"
    true
  when 'safari'
    puts "!!!HEY!!!"
    Capybara.current_driver = :selenium_safari
  else
    Capybara.current_driver = :selenium_chrome
end
#Capybara.current_driver = if ENV['HEADLESS'].nil? then :selenium_chrome else :poltergeist end



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
