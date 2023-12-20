# frozen_string_literal: true

require 'capybara'
require 'capybara/rspec'
require 'debug'
require 'selenium-webdriver'
require 'site_prism'

require 'support/capybara_browser'
require 'support/config'
require 'support/page_helpers'

## Configure Test Framework ##
RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
end
