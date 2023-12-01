# frozen_string_literal: true

# General helper methods for the page
def page_base_url
  Config::Pages.page_base_url
end

# Helpers for the Login Page
def valid_login_username
  Config::Pages.valid_login_username
end

def valid_login_password
  Config::Pages.valid_login_password
end
