# frozen_string_literal: true

require 'capybara'
require 'capybara/cuprite'
require 'capybara/rspec'

require_relative 'config'

### METHODS ###
# Creates the Cuprite-based Capybara-driven browser
# Cuprite only supports Chrome/chromium
def create_cuprite_browser
  Capybara.register_driver(:capybara_cuprite) do |app|
    Capybara::Cuprite::Driver.new(
      app,
      process_options: { host: "seleniumbrowser", port: 9222 },
      url: Config::Capybara.remote_browser_url,
      headless: Config::Capybara.headless?,
      browser_options: cuprite_browser_options
    )
  end

  Capybara.default_driver = :capybara_cuprite
end

def cuprite_browser_options
  # Chromium only
  {
    "no-sandbox": nil,
    "disable-dev-shm-usage": nil,
    "remote-allow-origins": "*"
  }
end
