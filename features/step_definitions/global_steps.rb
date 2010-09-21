Given /^the following (.+) records?$/ do |factory, table|
  table.hashes.each do |hash|
    Factory(factory, hash)
  end
end

Then /^I should see labels (.+)$/ do |labels|
  labels.split(', ').each do |label|
    with_scope('label') do
      if page.respond_to? :should
        page.should have_content(label)
      else
        assert page.has_content?(label)
      end
    end
  end
end