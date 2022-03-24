# copied from
# https://nts.strzibny.name/how-to-test-static-sites-with-rspec-capybara-and-webkit/

require 'rack'
require 'capybara'
require 'capybara/dsl'
require 'capybara/session'
require 'capybara/rspec'

class JekyllSite
  attr_reader :root, :server

  def initialize(root)
    @root = root
    @server = Rack::File.new(root)
  end

  def call(env)
    path = env['PATH_INFO']

    # Use index.html for / paths
    if path == '/' && exists?('index.html')
      env['PATH_INFO'] = '/index.html'
    elsif !exists?(path) && exists?(path + '.html')
      env['PATH_INFO'] += '.html'
    end

    server.call(env)
  end

  def exists?(path)
    File.exist?(File.join(root, path))
  end
end

# Setup for Capybara to test Jekyll static files served by Rack
Capybara.app = Rack::Builder.new do
  map '/' do
    use Rack::Lint
    run JekyllSite.new(File.join(File.dirname(__FILE__), '..', '_site'))
  end
end.to_app

Capybara.default_selector =  :css
Capybara.default_driver   =  :rack_test
Capybara.javascript_driver = :webkit

RSpec.configure do |config|
  config.include Capybara::DSL

  # Make sure the static files are generated
  `jekyll build` unless File.directory?('_site')
end
