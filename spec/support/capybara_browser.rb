# frozen_string_literal: true

require 'capybara'
require 'capybara/rspec'

require_relative 'capybara_cuprite'
require_relative 'capybara_selenium'

### METHODS ###
# Main method that determines and creates the Capybara-driven browser
def create_browser
  case capybara_driver
  when :selenium
    create_selenium_browser
  when :cuprite
    create_cuprite_browser
  else
    raise "Unknown CAPYBARA_DRIVER=#{driver.inspect}"
  end
end

def capybara_driver
  Config::Capybara.driver
end

### MAIN ###
create_browser
