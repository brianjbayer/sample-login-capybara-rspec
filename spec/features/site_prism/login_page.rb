=begin
class SearchPage < SitePrism::Page
  set_url "http://www.google.com"

  element :search_field, "input[name='q']"
  element :google_search, "button[value='Search']"
  element :logo, '#hplogo'

  def search_for(text)
    search_field.set text
    google_search.click if ENV['HEADLESS'].nil? #terrible hack not worth spending time on
  end
end

        loginFormUsernameInput { loginForm.$("input[name=username]") }
        loginFormPasswordInput { loginForm.$("input[name=password]") }
        loginFormSubmitButton  { loginForm.$("button[type=submit]") }

=end


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