# frozen_string_literal: true

require 'spec_helper'
require_relative 'login_steps'
require_relative 'site_prism/login_page'
require_relative 'site_prism/secure_area_page'

feature 'User logs in' do
  let(:login_page)       { LoginPage.new }
  let(:secure_area_page) { SecureAreaPage.new }

  scenario 'user logs in with valid credentials and is sent to the secure area' do
    user_goes_to_the_login_page
    user_logins_with_valid_credentials
    user_must_be_sent_to_the_secure_area_page
  end

  ### STEPS ###
  def user_logins_with_valid_credentials
    login_page.login_with_valid_credentials
  end

  def user_must_be_sent_to_the_secure_area_page
    # Expect the page to be loaded/displayed within 5 seconds
    expect(secure_area_page.displayed?(5)).to be true
  end
end
