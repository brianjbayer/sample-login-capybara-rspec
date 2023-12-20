# frozen_string_literal: true

class LoginPage < SitePrism::Page
  set_url "#{page_base_url}/login"

  element :username_input, 'input[id="username"]'
  element :password_input, 'input[id="password"]'
  element :submit_button, 'button[type="submit"]'

  element :login_error, '#flash'

  def login_with_valid_credentials
    username_input.set valid_login_username
    password_input.set valid_login_password
    submit_button.click
  end

  def login_with_invalid_password
    username_input.set valid_login_username
    password_input.set 'NotAValidPassword'
    submit_button.click
  end
end
