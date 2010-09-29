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
    when /^the admin org(s|\sindex) page$/
      admin_orgs_path
    when /^the admin new org page$/
      new_admin_org_path
    when /^admin index page for activities$/
      admin_activities_path
    when /^new admin activity page$/
      new_admin_activity_path
      
    when /^the Organization Categories page$/
      admin_org_categories_path
    when /^the New Organization Category page$/
      new_admin_org_category_path
    when /^the Edit Organization Category page for "(.*)"$/
      edit_admin_org_category_path(OrgCategory.find_by_title($1))
    when /^the Organization Category page for "(.*)"$/  
      admin_org_category_path(OrgCategory.find_by_title($1))
    when /^the Edit Organization page for "(.*)"$/
      edit_admin_org_path(Org.find_by_name($1))
    when /^the Organization page for "(.*)"$/
      admin_org_path(Org.find_by_name($1))
      
    when /^the Activity Categories Admin page$/
      admin_activity_categories_path
    when /^the New Activity Category page$/
      new_admin_activity_category_path
    when /^the Activity Category Edit page for "(.*)"$/
      edit_admin_activity_category_path(ActivityCategory.find_by_name($1) || ActivityCategory.find_by_permalink($1))

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
