@anonymous
Feature: Viewing the Site
  In order to be directed to the appropriate actions
  As a site visitor
  I want to see the content that is intended for me

  Scenario: Anonymous Visitor to the Homepage
    Given I am not logged in
    And I am on the homepage
    Then I should see "Register Now!" 
  
  # Scenario: Beginning the Registration Process for Parents or Camp Owners
  #   Given I am not logged in
  #   Given I am on the homepage
  #   When I follow "Register Now!"
  #   Then I should be on the <something> page
  #   And I should see <something>