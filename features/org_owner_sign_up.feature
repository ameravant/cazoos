Feature: Org owner sign up
  In order to add my organization to Cazoos
  As an organization owner  
  I want to sign up
  
  @org_owner_sign_up
  Scenario: Signing up
    Given I am not logged in
    And I am on the homepage  
    Then I should see "Organization or Camp owner Sign up"
    When I follow "Organization or Camp owner Sign up"
    Then I should be on the new org owner page
    And I should see "Add your camp to Cazoos!"
    When I fill in the required info
    And I press "Add my camp"
    Then I should be on the admin org edit page
    And I should see "You've added your Organization for review. We'll send an email shortly. Thank you!"
    
  
  
  

  
