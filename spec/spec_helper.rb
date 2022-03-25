require 'rspec'
require 'capybara/rspec'
require 'rack/jekyll'
require 'yaml'
require 'selenium-webdriver'

# Configure Capybara to use Selenium.
Capybara.register_driver :selenium do |app|
  # Configure selenium to use Chrome.
  Capybara::Selenium::Driver.new(
    app,
    :browser => :chrome,
    # remove options hash if you want to run the tests in a browser
    options: Selenium::WebDriver::Chrome::Options.new(args: %w[headless disable-gpu])
  )
end

# Configure Capybara to load the website through rack-jekyll.
# (force_build: true) builds the site before the tests are run,
# so our tests are always running against the latest version
# of our jekyll site.
Capybara.app = Rack::Jekyll.new(force_build: true)


RSpec.configure do |config|
  config.include Capybara::DSL
  config.include(YAML)
end