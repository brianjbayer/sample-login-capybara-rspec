class LoginPage < SitePrism::Page
  set_url "http://the-internet.herokuapp.com/login"

  element :username_input, "input[name=username]"
  element :password_input, "input[name=password]"
  element :submit_button,  "button[type=submit]"

  def login_with_valid_credentials
    username_input.set "tomsmith"
    password_input.set "SuperSecretPassword!"
    submit_button.click
  end

end