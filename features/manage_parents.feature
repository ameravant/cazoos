@parents
Feature: Create and manage parent and child profiles

Background:
  Given the following parent record
    | first_name | last_name | email          | address1     | city        | state | zip   | phone      |
    | John       | Adams     | john@adams.com | 1234 Main St | Santa Maria | CA    | 93222 | 8055551212 |

  @parent_new
  Scenario: Create a Parent Profile
    Given I am not logged in
    And I am on the homepage
    Then I should see "Register Now!" within "a" 
    When I follow "Register Now!"
    Then I should be on the New Person page    
    When I fill in "First name" with "John"
    And I fill in "Last name" with "Adams"
    And I fill in "Email" with "new@blah.com"
    And I fill in "Address1" with "1234 Main St"
    And I fill in "City" with "Santa Maria"
    And I select "California" from "State"
    And I fill in "Zip" with "93222"
    And I fill in "Phone" with "8055551212"
    And I fill in "Password" with "password"
    And I fill in "Password confirmation" with "password"
    And I press "Sign Up!"
    Then I should be on the login page
    And I should see "Thanks for joining! Please log in to complete your profile."

  @parent_edit
  Scenario: Edit a Parent Profile
    Given I am logged in as person with email "john@adams.com" with password "secret"
    Then I should be on the Parent Edit page for "john@adams.com"
    And the "First name" field should contain "John"
    And the "Last name" field should contain "Adams"
    And the "Email" field should contain "john@adams.com"
    And the "Address1" field should contain "1234 Main St"
    And the "City" field should contain "Santa Maria"
    And the "State" field should contain "California" 
    And the "Zip" field should contain "93222"
    And the "Phone" field should contain "8055551212"
    When I fill in "Last name" with "Jacobs"
    And I select "Arizona" from "State"
    And I fill in "Phone" with ""
    And I press "Update Profile"
    Then I should be on the admin People page
    And I should see "Person updated!"
    And I should see "John Jacobs"
    When I follow "John Jacobs"
    Then I should be on the Parent Edit page for "john@adams.com"
    And the "Last name" field should contain "Jacobs"
    And the "State" field should contain "Arizona" 
    And the "Phone" field should contain ""

  # @child_edit
  # Scenario: As a logged in parent I should be able to edit my children
  #   Given I am logged in as person with email "john@adams.com" with password "secret"
  #   Then I should be on the Parent Show page for "john@adams.com"
  
  
  
  @add_childrens
  Scenario: As a logged in parent I should be able to add children 
    Given I am logged in as person with email "john@adams.com" with password "secret"
    Then I should be on the Parent Edit page for "john@adams.com"
    And I should see "Add a child"
    When I follow "Add a child"
    Then I should be on the New Child page
    And the "Last name" field should contain "Adams"
    When I fill in "First name" with "Timmy"
    And I fill in "Last name" with "Tommy"
    #Date select?
    # And I select "January" from "Month"
    # And I select "12" from "Day"
    # And I select "1999" from "Year"
    And I fill in "Height" with "4.5"
    And I choose "Male" 
    And I fill in "Weight" with "80"
    And I fill in "School" with "Santa Barbara Elementary"
    And I fill in "Allergies" with "Food and water"
    And I fill in "Family doctor" with "Dr. Jekyll"
    And I fill in "Doctor phone" with "8050081200"
    And I fill in "Insurance carrier" with "Public option"
    And I fill in "Policy number" with "123123123"
    And I fill in "Policy holder name" with "Bilbo Baggins"
    And I press "Save Child"
    Then I should be on the Parent Edit page for "john@adams.com"
    And I should see "Timmy Tommy"
    
  @invalid_parent_new
  Scenario: Trying to create a Parent Profile that already exists
    Given I am not logged in
    And I am on the homepage
    Then I should see "Register Now!" within "a" 
    When I follow "Register Now!"
    Then I should be on the New Person page    
    When I fill in "First name" with "John"
    And I fill in "Last name" with "Adams"
    And I fill in "Email" with "john@adams.com"
    And I fill in "Address1" with "1234 Main St"
    And I fill in "City" with "Santa Maria"
    And I select "California" from "State"
    And I fill in "Zip" with "93222"
    And I fill in "Phone" with "8055551212"
    And I fill in "Password" with "password"
    And I fill in "Password confirmation" with "password"
    And I press "Sign Up!"
    Then I should be on the People page
    And I should see "is an email address already in the system"
    When I fill in "Email" with "unique@new.com"
    And I press "Sign Up!"
    Then I should be on the login page
    And I should see "Thanks for joining! Please log in to complete your profile."

  @parent_login  
  Scenario: Invalid and proper login in as a Parent
    Given I am logged in as person with email "john@adams.com" with password "wrong"
    Then I should see "Your account information could not be verified. Please try again."
    Given I am logged in as person with email "john@adams.com" with password "secret"
    Then I should be on the Parent Edit page for "john@adams.com"