Then /^I should see "([^"]*)" within span\#min_age$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end

Then /^I should see "([^"]*)" within span\#max_age$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end

Given /^no org records$/ do 
  Org.delete_all
end
   
