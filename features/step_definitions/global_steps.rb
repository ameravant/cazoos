Given /^the following (.+) records?$/ do |factory, table|
  table.hashes.each do |hash|
    Factory(factory, hash)
  end
end

Then /^I should see labels "([^"]*)"(?: within "([^"]*)")?$/ do |labels, selector|
  labels.split(', ').each do |label|
    with_scope("#{selector} label") do
      if page.respond_to? :should
        page.should have_content(label)
      else
        assert page.has_content?(label)
      end
    end
  end
end
# should see "([^"]*)"(?: within "([^"]*)")?$/
# Then /^I should see inputs "([^"]*)"$/ do |inputs|
#   inputs.split(', ').each do |field|
#     field = find_field(field)
#     assert !field.nil?
#   end
# end

Then /^I should see inputs "([^"]*)"(?: within "([^"]*)")?$/ do |inputs, selector|
  inputs.split(', ').each do |field|
    with_scope(selector) do 
      field = find_field(field)
      assert !field.nil?
    end
  end
end