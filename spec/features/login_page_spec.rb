# frozen_string_literal: true

require 'spec_helper'
require_relative 'site_prism/login_page'
require_relative 'site_prism/secure_area_page'

describe 'Login page' do
  # NOTE: Scenarios check visibility which implicitly checks presence

  let(:login_page) { LoginPage.new }

  before do
    login_page.load
  end

  it { expect(login_page).to be_displayed }

  it 'has a visible username input' do
    expect(login_page.username_input).to be_visible
  end

  it 'has a visible password input' do
    expect(login_page.password_input).to be_visible
  end

  it 'has a visible submit button' do
    expect(login_page.submit_button).to be_visible
  end
end
