require 'capybara'
require 'capybara/rspec'
require 'site_prism'
require 'capybara/poltergeist'

Capybara.register_driver :selenium_chrome do |app|
    Capybara::Selenium::Driver.new(app, :browser => :chrome)
end

Capybara.configure do |c|
#  c.app_host = 'http://www.google.com'
  c.javascript_driver =  :selenium
  c.default_driver = :poltergeist
  c.current_driver = :poltergeist
  c.default_driver = :selenium_chrome if ENV['HEADLESS'].nil?
  c.current_driver = :selenium_chrome if ENV['HEADLESS'].nil?
  c.run_server = false
  c.default_max_wait_time = 15
end

SitePrism.configure do |config|
  config.use_implicit_waits = true
end

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
end
