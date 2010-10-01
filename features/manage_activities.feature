@activities
Feature: Adding an activity
  In order to have activities for org owners to choose from
  As an admin 
  I want add new activities to the system
  
  Background:
    Given the following activity records
      | name                 | description                                                 |
      | Horseback Riding 101 | Beginning Horseback Riding, perfect for ages 9-13...        |
      | Archery              | For the child who likes to push him/herself, concentrate... |
    Given the following org record
      | name       |
      | Camp Valid |
      
  @activities_index  
  Scenario: Vising the Activities Admin page
    Given I am logged in as the owner of "Camp Valid" with password "secret"
    And I am on the Activities Admin page
    Then I should see "Activities" within "h1"
    # When I follow "Activities"
    # Then I should be on the admin index page for activities
    # And I should see "Add a new Activity"
    # When I follow "Add a new Activity"
    # Then I should be on the new admin activity page
    # And I should see "Add a new Activity"
    # And I should see fields labeled Title
    # When I fill in "Title" with "New Activity"
    # And I press "Create Activity"
    # Then I should be on the admin index page for activities
    # And I should see "New Activity"
  
  
  

  
