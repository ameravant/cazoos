@parents
Feature: Create and manage parent and child profiles

Background:
  Given the following parent record
    | first_name | last_name | email          | address1     | city        | state      | zip   | phone      |
    | John       | adams     | john@adams.com | 1234 Main St | Santa Maria | California | 93222 | 8055551212 |
  
  @parent_new
  Scenario: Creating a Parent Profile 
    Given I am not logged in
    And I am on the homepage
    Then I should see "Register Now!" within "a" 
    When I follow "Register Now!"
    Then I should be on the New Person page    
    When I fill in "person[first_name]" with "John"
    And I fill in "person[last_name]" with "Adams"
    And I fill in "person[email]" with "john@adams.com"
    And I fill in "person[address1]" with "1234 Main St"
    And I fill in "person[city]" with "Santa Maria"
    And I select "California" from "person[state]"
    And I fill in "person[zip]" with "93222"
    And I fill in "person[phone]" with "8055551212"
    And I fill in "person[user_attributes][password]" with "password"
    And I fill in "person[user_attributes][password_confirmation]" with "password"
    And I press "Sign Up!"
    Then I should be on the login page

  @parent_login  
  Scenario: Logging in as a Parent
    Given I am not logged in
    And I am logged in as "john@adams.com" with password "secret"
    Then I should be on the Parent Edit page for "john@adams.com"