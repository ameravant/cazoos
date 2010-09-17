def logout
  visit '/session/new'
end

Given /^I am not logged in$/ do
  logout  
end
