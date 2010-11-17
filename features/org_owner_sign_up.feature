Feature: Org owner sign up
  In order to add a new organization to Cazoos
  As an admin  
  I want to sign up a new org
  
  # @org_owner_sign_up
  #   Scenario: Signing up
  #     Given I am not logged in
  #     And I am on the homepage  
  #     Then I should see "Organization or Camp owner Sign up"
  #     When I follow "Organization or Camp owner Sign up"
  #     Then I should be on the new org owner page
  #     And I should see "Add your camp to Cazoos!"
  #     When I fill in the required info
  #     And I press "Add my camp"
  #     Then I should be on the admin org edit page
  #     And I should see "You've added your Organization for review. We'll send an email shortly. Thank you!"
  #     
  
  @org_owner_sign_up
  Scenario: Signing up a new org owner
    Given I am logged in as "admin" with password "admin"  
    And I am on the admin dashboard page
    Then I should see "Organizations"
    When I follow "Organizations"
    Then I should be on the Organizations Admin page
    And I should see "Add a New Organization"
    When I follow "Add a New Organization"
    Then I should be on the new org owner page
    And I should see "Organization Owner Details"
    And I should see "Step 1"
    When I fill in "First name" with "John"
    And I fill in "Last name" with "Wilson"
    And I fill in "Email" with "john@wilson.com"
    And I fill in "Password" with "password"
    And I fill in "Password confirmation" with "password"
    And I press "Next Step"
    Then I should be on the New Organization Type page 
    And I should see "Is the type of this Organization in the list? If not create the new type below."
    And I should see "The Type is in the list, continue to the next step"
    When I fill in "Title" with "Pre-School"
    And I fill in "Description" with "Its a school! A place where people learn!"
    And I press "Create Type"
    Then I should be on the New Organization page
    And I should see "Add Organization Details"
    When I select "School" from "Organization Type"
    And I fill in "Name of Organization" with "Awesome Org"
    And I fill in "Description" with "description"
    And I fill in "Blurb" with "blurb"
    And I select "boys" from "Gender"
    And I fill in "org_min_age" with "5"
    And I fill in "org_max_age" with "10"
    And I fill in "Address" with "address"
    And I fill in "City" with "city"
    And I select "California" from "State"
    And I fill in "Zip Code" with "11111"
    And I fill in "Contact Email" with "bill@bill444.com"
    And I fill in "Main Contact" with "Bill Wilson"
    And I fill in "Main Contact Phone" with "123-234-3333"
    And I press "Create Organization"
    Then I should be on the Organizations Admin page
    And I should see "You have successfully created a new organization."
    And I should see "Awesome Org"
    When I follow "Awesome Org"
    Then I should see "Awesome Org"
    And I should see "Owner: John Wilson"
    
  
  
  
  

  
