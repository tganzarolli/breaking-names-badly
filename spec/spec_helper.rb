ENV["RACK_ENV"] = 'test'
require File.join(File.dirname(__FILE__), '..', 'app.rb')

require 'rubygems'
require 'sinatra'
require 'rack/test'
require 'json'

set :environment, :test

def app
  @app ||= Sinatra::Application
end