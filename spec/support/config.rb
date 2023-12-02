# frozen_string_literal: true

module Config
  # (Required) Configuration for PageObject pages
  module Pages
    def self.page_base_url
      ENV.fetch('BASE_URL')
    end

    def self.valid_login_username
      ENV.fetch('LOGIN_USERNAME')
    end

    def self.valid_login_password
      ENV.fetch('LOGIN_PASSWORD')
    end
  end
end

module Config
  # Configuration for Capybara-driven browser
  module Capybara
    def self.browser
      ENV.fetch('BROWSER', nil)
    end

    def self.remote_browser_url
      ENV.fetch('REMOTE', nil)
    end

    def self.headless?
      # Support HEADLESS= as true, but HEADLESS=false as false
      ENV.fetch('HEADLESS', false).to_s.downcase != 'false'
    end
  end
end
