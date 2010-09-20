require File.dirname(__FILE__) + "/../../spec/factories"

def logout
  visit '/session/new'
end

Given /^I am not logged in$/ do
  logout  
end

Given /^I am logged in as "(.*)" with password "(.*)"$/ do |username, password|
  # AuthenticatedSystem::login_from_basic_auth(username, password)
  # @current_user = Factory.create!(:user, :username => username, :password => password, :password_confirmation => password)
end
