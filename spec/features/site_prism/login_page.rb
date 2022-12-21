# frozen_string_literal: true

class LoginPage < SitePrism::Page
  set_url 'http://the-internet.herokuapp.com/login'

  element :username_input, 'input[id="username"]'
  element :password_input, 'input[id="password"]'
  element :submit_button, 'button[type="submit"]'

  def login_with_valid_credentials
    username_input.set ENV.fetch('LOGIN_USERNAME')
    password_input.set ENV.fetch('LOGIN_PASSWORD')
    submit_button.click
  end
end
