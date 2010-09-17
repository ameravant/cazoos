Feature: Viewing the Site
  In order to be directed to the appropriate actions
  As a site visitor
  I want to see the content that is intended for me

  Scenario: Anonymous Visitor to the Homepage
    Given I am not logged in
    When I go to to the homepage
    Then I should see "Register Now!" within "a" 
