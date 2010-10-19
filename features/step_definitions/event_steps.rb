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

When /^I fill in the Event form with valid values$/ do
  fill_in('event_name', :with => "Horseback Riding 101")
  fill_in('event_address', :with => "1624 Olive St., Santa Barbara, CA 93101")
  fill_in('event_description', :with => "Beginning Horseback Riding, perfect for ages 9-13...")
  fill_in('event_registration_limit', :with => "12")
  fill_in_datetime("July 5, 2011 09:00 am", "Event Start date/time", 'form#new_event')
  fill_in_datetime("July 9, 2011 05:00 pm", "Event End date/time", 'form#new_event')
  fill_in_datetime("June 15, 2011 11:59 pm", "Registration deadline", 'form#new_event')
end

