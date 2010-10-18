Then /^the "([^"]*)" field within "([^"]*)" should contain the mappable address of the Org with "([^"]*)"$/ do |field, selector, offering|
  with_scope(selector) do
    field = find_field(field)
    field_value = (field.tag_name == 'textarea') ? field.text : field.value
    if field_value.respond_to? :should
      field_value.should =~ /#{Offering.find_by_name(offering).org.map_address}/
    else
      assert_match(/#{Offering.find_by_name(offering).org.map_address}/, field_value)
    end
  end
end