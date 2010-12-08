Feature: Adding an offering as camp owner
  In order to show people what kind of camps I have
  As a camp owner 
  I want to add offerings
  
  Scenario: Adding offering
    Given the following camp_owner records
    Given the following parent records
    Given I am logged in as "camp-owner" with password "password"
    Then I should see "Offerings"
    When I follow "Offerings"
    Then I should be on the offering page for
  
  
  

  
