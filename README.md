# sample-login-capybara-rspec

## Overview
This is an example of End-To-End (E2E) Tests/Acceptance Test
Driven Development (ATDD) using
[Capybara](https://github.com/teamcapybara/capybara),
[RSpec](http://rspec.info/), [Ruby](https://www.ruby-lang.org).

**However, it also provides a somewhat extensible framework that
can be reused by replacing the existing tests.**

These tests show how to use Capybara-RSpec to verify...
* The ability to login as a user
* That critical elements are on a page

It also demonstrates the basic features of the
Capybara-RSpec framework and how they can be extended.

## Run Locally or in Containers
This project can be run...
* Locally containerized in 2 separate Docker containers:
  one containing the tests, the other the browser
* Locally natively running the tests against a local browser
  or a containerized browser

## Contents of this Framework
This framework contains support for...
* Using Selenium Standalone containers eliminating the need
  for locally installed browsers or drivers
* Multiple local browsers with automatic driver management
* Headless execution for those browsers that support it
* Single-command docker compose framework to run
  the tests or a supplied command
* Native through fully-containerized execution
* Containerized development environment
* Continuous Integration with GitHub Actions vetting
  linting, static security scanning, and functional
  tests
* Basic secrets management using environment variables and
  [GitHub Secrets](https://docs.github.com/en/actions/security-guides/encrypted-secrets)

## Running
The easiest way to run the tests is with the docker compose
framework using the `dockercomposerun` script.

This will pull the latest docker image of this project and run
the tests against a
[Selenium Standalone](https://github.com/SeleniumHQ/docker-selenium)
container.

You can view the running tests using the included
Virtual Network Computing (VNC) server.

### Prerequisites
1. You must have Docker installed and running on your local machine.
2. You must specify the login credentials (i.e. secrets) used in the
   test with the `LOGIN_USERNAME` and `LOGIN_PASSWORD` environment
   variables...
   ```
   LOGIN_USERNAME=tomsmith LOGIN_PASSWORD=SuperSecretPassword!
   ```

### Running Using the Default Chrome Standalone Container
By default, the `dockercomposerun` script runs using the
latest Selenium Standalone Chrome container.

1. Ensure Docker is running
2. From the project root directory, run the `dockercomposerun`
   script with the defaults...

   ```
   LOGIN_USERNAME=tomsmith LOGIN_PASSWORD=SuperSecretPassword! ./script/dockercomposerun
   ```

### Optional: Creating a `.env` File
You can create a file named `.env` in the project root directory
that contains the required environment variables that will
be used by default by Docker Compose instead of setting them on
the command line...
```
LOGIN_USERNAME=tomsmith
LOGIN_PASSWORD=SuperSecretPassword!
```

> Note that files in the project root directory starting with the
> name `.env` are ignored by this repository and do not appear in
> deployment image

### Seeing the Tests Run
> Browsers in the containers are not visible in the VNC server
> when running headless

The Selenium Standalone containers used in the docker compose
framework have an included VNC server for viewing and
debugging the tests.

You can use either a VNC client or a web browser to view the tests.

1. Ensure that you are running the Selenium Standalone containers
   (e.g. in the docker compose framework)
2. To view the tests... using a web browser, navigate to
   http://localhost:7900/; or to use a VNC server, use
   `vnc://localhost:5900` (On Mac you can simply enter
   this address into a web browser)
3. When prompted for the (default) password, enter `secret`

For more information, see the Selenium Standalone Image
[VNC documentation](https://github.com/SeleniumHQ/docker-selenium#debugging)

### Running Using Other Selenium Standalone Containers
You can also run the tests using other Selenium Standalone
containers (such as Firefox and Edge) with the docker compose
framework.

For more information, see
[RUNNING_WITH_OTHER_CONTAINERS.md](docs/RUNNING_WITH_OTHER_CONTAINERS.md).

### Running Interactively (i.e. "Shell In")
You can run the tests interactively by "shelling in" to the
test container.

1. Ensure Docker is running
2. From the project root directory, run the `dockercomposerun`
   script and supply the shell command `sh`...
   ```
   LOGIN_USERNAME=tomsmith LOGIN_PASSWORD=SuperSecretPassword! ./script/dockercomposerun sh
   ```
3. Run desired commands in the container
   (e.g. `bundle exec rake`)
4. Run the exit command to exit the Test container
   ```
   exit
   ```

## Running Natively and Environment Variables
Assuming that you have a Ruby development environment,
the tests either can be run directly by the RSpec
runner or by the supplied Rakefile.

For more information, see [RUNNING_NATIVELY.md](docs/RUNNING_NATIVELY.md).

## Development
This project can be developed using the supplied container-based
development environment which includes `vim` and `git`.

For more information, see [DEVELOPMENT.md](docs/DEVELOPMENT.md).

## Sources and Additional Information
These tests use the...
* SitePrism page object gem: [SitePrism docs](http://www.rubydoc.info/gems/site_prism/index),
[SitePrism on GitHub](https://github.com/natritmeyer/site_prism)
* Webdrivers browser driver helper gem: [Webdrivers on GitHub](https://github.com/titusfortner/webdrivers)
* Selenium Standalone Debug Containers: [Selenium HQ on GitHub](https://github.com/SeleniumHQ/docker-selenium)
* Rubocop style enforcer and linter: [Rubocop docs](https://rubocop.org/),
  [Rubocop on GitHub](https://github.com/rubocop/rubocop)
* bundler-audit dependency static security scanner: [bundler-audit on GitHub](https://github.com/rubysec/bundler-audit)
