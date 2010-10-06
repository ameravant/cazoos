@parents
Feature: Create and manage parent and child profiles

Background:
  Given the following parent record
    | first_name | last_name | email          | address1     | city        | state      | zip   | phone      |
    | John       | adams     | john@adams.com | 1234 Main St | Santa Maria | California | 93222 | 8055551212 |

  @parent_new
  Scenario: Create a Parent Profile
    Given I am not logged in
    And I am on the homepage
    Then I should see "Register Now!" within "a" 
    When I follow "Register Now!"
    Then I should be on the New Person page    
    When I fill in "person_first_name" with "John"
    And I fill in "person_last_name" with "Adams"
    And I fill in "person_email" with "new@blah.com"
    And I fill in "person_address1" with "1234 Main St"
    And I fill in "person_city" with "Santa Maria"
    And I select "California" from "person_state"
    And I fill in "person_zip" with "93222"
    And I fill in "person_phone" with "8055551212"
    And I fill in "person_user_attributes_password" with "password"
    And I fill in "person_user_attributes_password_confirmation" with "password"
    And I press "Sign Up!"
    Then I should be on the login page
    And I should see "Thanks for joining! Please log in to complete your profile."

  @invalid_parent_new
  Scenario: Trying to create a Parent Profile that already exists
    Given I am not logged in
    And I am on the homepage
    Then I should see "Register Now!" within "a" 
    When I follow "Register Now!"
    Then I should be on the New Person page    
    When I fill in "person_first_name" with "John"
    And I fill in "person_last_name" with "Adams"
    And I fill in "person_email" with "john@adams.com"
    And I fill in "person_address1" with "1234 Main St"
    And I fill in "person_city" with "Santa Maria"
    And I select "California" from "person_state"
    And I fill in "person_zip" with "93222"
    And I fill in "person_phone" with "8055551212"
    And I fill in "person_user_attributes_password" with "password"
    And I fill in "person_user_attributes_password_confirmation" with "password"
    And I press "Sign Up!"
    Then I should be on the Person page for "john@adams.com"
    And I should see "is an email address already in the system"
    When I fill in "person_email" with "unique@new.com"
    And I press "Sign Up!"
    Then I should be on the login page
    And I should see "Thanks for joining! Please log in to complete your profile."

  @parent_login  
  Scenario: Invalid and proper login in as a Parent
    Given I am logged in as parent with email "john@adams.com" with password "wrong"
    Then I should see "Your account information could not be verified. Please try again."
    Given I am logged in as parent with email "john@adams.com" with password "secret"
    Then I should be on the Parent Edit page for "john@adams.com"