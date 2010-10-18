module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /the home\s?page/
      '/'
    #~~~~LOGIN HERE~~~~
    when /^the login page$/
      new_session_path
    
    when /^the New Person page$/
      new_person_path
    when /^the Parent Edit page for "(.*)"$/
      edit_admin_person_path(Person.find_by_email($1))
    when /^the People page$/
      people_path
    when /^the admin People page$/
      admin_people_path

    when /^the New Child page$/
      new_admin_child_path
      
    when /^the Organization Types Admin page$/
      admin_org_types_path
    when /^the New Organization Type page$/
      new_admin_org_type_path
    when /^the Organization Type Edit page for "(.*)"$/
      edit_admin_org_type_path(OrgType.find_by_title($1))
    when /^the Organization Type page for "(.*)"$/  
      admin_org_type_path(OrgType.find_by_title($1))
      
    when /^the Organizations Admin page$/
      admin_orgs_path
    when /^the New Organization page$/
      new_admin_org_path
    when /^the Organization Edit page for "(.*)"$/
      edit_admin_org_path(Org.find_by_name($1))
    when /^the Organization page for "(.*)"$/
      admin_org_path(Org.find_by_name($1))
      
    when /^the Activity Categories Admin page$/
      admin_activity_categories_path
    when /^the New Activity Category page$/
      new_admin_activity_category_path
    when /^the Activity Category page for "(.*)"$/
      admin_activity_category_path(ActivityCategory.find_by_name($1) || ActivityCategory.find_by_permalink($1))
    when /^the Activity Category Edit page for "(.*)"$/
      edit_admin_activity_category_path(ActivityCategory.find_by_name($1) || ActivityCategory.find_by_permalink($1))

    when /^the Offerings Admin page$/
      admin_offerings_path
    when /^the New Offering page for the Org with "([^"]*)"$/
      new_admin_org_offering_path(Offering.find_by_name($1).org)
    when /^the Offering Edit page for "(.*)"$/
      edit_admin_offering_path(Offering.find_by_name($1))
    when /^the Offering page for "(.*)"$/
      admin_offering_path(Offering.find_by_name($1))
    when /^the Offering page for "(.*)" specific to its Org$/
      admin_org_offering_path(Offering.find_by_name($1).org, Offering.find_by_name($1))
    when /^the Offerings Admin page for the Org with "([^"]*)"$/
      admin_org_offerings_path(Offering.find_by_name($1).org)
    when /^the Offering Edit page for "([^"]*)" specific to its Org$/
      edit_admin_org_offering_path(Offering.find_by_name($1).org, Offering.find_by_name($1))      

    when /^the Events Admin page for the "(.*)" offering$/
      admin_offering_events_path(Offering.find_by_name($1))
    when /^the New Event page for the "(.*)" offering$/
      new_admin_offering_event_path(Offering.find_by_name($1))
      
    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      begin
        page_name =~ /the (.*) page/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue Object => e
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)
