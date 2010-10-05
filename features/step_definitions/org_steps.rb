When /^I fill in the Org form with valid data(?: and call it "([^"]*)")$/ do |name|
  org_type = OrgType.last
  owner = PersonGroup.find_by_title('Organization Owner').people.last
  
  inputs = %w{name description blurb min_age max_age contact contact_phone contact_email address city zip}
  selects = %w{gender}
  
  org = Factory.build(:org)
  
  inputs.each do |input|
    fill_in("org_#{input}", :with => org[input.to_sym])
  end
  
  selects.each do |select|
    select(org[select.to_sym], :from => "org_#{select}")
  end

  select("California", :from => "org_state")  
  select(org_type.title, :from => "org_org_type_id")
  select("#{owner.first_name} #{owner.last_name}", :from => "org_owner_id")
  
  fill_in("org_name", :with => name) if !name.nil?
end