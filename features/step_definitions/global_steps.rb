Given /^the following ([\w]+) records?$/ do |factory, table|
  table.hashes.each do |hash|
    Factory(factory, hash)
  end
end

Given /^the following transposed ([\w]+) records?$/ do |factory, table|
  table.transpose.hashes.each do |hash|
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

Then /^I should see inputs "([^"]*)"(?: within "([^"]*)")?$/ do |inputs, selector|
  inputs.split(', ').each do |field|
    with_scope(selector) do 
      field = find_field(field)
      if field.respond_to? :should
        field.should_not be_nil
      else
        assert !field.nil?
      end
    end
  end
end