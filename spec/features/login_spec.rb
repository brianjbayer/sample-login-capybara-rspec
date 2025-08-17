# frozen_string_literal: true

require 'spec_helper'
require_relative 'site_prism/login_page'
require_relative 'site_prism/secure_area_page'

feature 'User logs in' do
  given(:login_page)       { LoginPage.new }
  given(:secure_area_page) { SecureAreaPage.new }

  background do
    login_page.load
    expect(login_page).to be_displayed
  end
  scenario 'with valid credentials and is sent to the secure area' do
    login_page.login_with_valid_credentials

    # Allow at least 5 seconds for page to load
    expect(secure_area_page).to be_displayed(5)
  end

  scenario 'with invalid password and an error is displayed' do
    login_page.login_with_invalid_password

    expect(login_page).to be_displayed
    expect(login_page).to have_login_error
    expect(login_page.login_error.text).to include('Your password is invalid!')
  end
end
