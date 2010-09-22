@act
Feature: Adding an activity
  In order to have activities for org owners to choose from
  As an admin 
  I want add new activities to the system
  
  Scenario: navigating to the new activity page
    Given I am logged in as "admin" with password "admin"
    # And there are no activity records
    Then I should see "Activities"
    When I follow "Activities"
    Then I should be on the admin index page for activities
    And I should see "Add a new Activity"
    When I follow "Add a new Activity"
    Then I should be on the new admin activity page
    And I should see "Add a new Activity"
    And I should see fields labeled Title
    When I fill in "Title" with "New Activity"
    And I press "Create Activity"
    Then I should be on the admin index page for activities
    And I should see "New Activity"
  
  
  

  
