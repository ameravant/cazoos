Given /^the following ([\w]+) records?$/ do |factory, table|
  # factory.camelize.constantize.delete_all
  table.hashes.each do |hash|
    Factory(factory, hash)
  end
end

Given /^the following transposed ([\w]+) records?$/ do |factory, table|
  # factory.camelize.constantize.delete_all
  table.transpose.hashes.each do |hash|
    Factory(factory, hash)
  end
end

Given /^no ([\w]+) records$/ do |record_type|
  record_type.camelize.constantize.delete_all
end

Given /^([\d]*) ([\w]+) records?$/ do |num, factory|
  num.to_i.times do
    Factory(factory)
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


Then /^I should see (input|select|textarea)s "([^"]*)"(?: within "([^"]*)")?$/ do |field_type, inputs, selector|
  inputs.split(', ').each do |field|
    with_scope(selector) do 
      # field = find_field(field)
      field = find(:xpath, "//#{field_type}[@id='#{field}']")
      if field.respond_to? :should
        field.should_not be_nil
      else
        assert !field.nil?
      end
    end
  end
end