# frozen_string_literal: true

require 'capybara'
require 'capybara/rspec'

require_relative 'capybara_selenium'

### METHODS ###
# Main method that determines and creates the Capybara-driven browser
def create_browser
  # Default is Selenium-based browser driver
  create_selenium_browser
end

### MAIN ###
create_browser
