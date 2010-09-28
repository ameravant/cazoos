@orgs
Feature: Manage Orgs
  In order to manage orgs (camps, schools, etc)
  As a SuperUser 
  I want to be able to create, edit and destroy orgs
  
  Background:
    Given no user records
    Given the following user record
      | login | password | password_confirmation |
      | admin | admin    | admin                 |
    Given I am logged in as "admin" with password "admin"
    Given the following transposed org records
      | name          | Camp TittiCaca                                | Camp DoYaWanna                              |
      | description   | Camp TittiCaca sits nestled in the forests... | Camp DoYaWanna is full of hard-to-resist... |
      | blurb         | A camp for a new generation                   | Camp for hyperactive children               |
      | min_age       | 5                                             | 9                                           |
      | max_age       | 9                                             | 12                                          |
      | gender        | boys                                          | coed                                        |
      | contact       | Jim Contact                                   | Joe Contact                                 |
      | contact_phone | 805-555-1212                                  | 800-396-CAMP                                |
      | contact_email | jim@camptitticaca.com                         | joe@campdoyawanna.com                       |  
  
  Scenario: Viewing Organizations
    When I go to the admin orgs page
    Then I should see "Organizations" within "h1"
    Then I should see "Camp TittiCaca" within "table#organizations.full_width tr.org td.org_name"
    And I should see "Camp TittiCaca sits nestled in the forests" within "table.full_width tr.org td.org_description"
    And I should see "A camp for a new generation" within "table.full_width tr.org td.org_blurb"
    And I should see "9" within "table.full_width tr.org td.org_age_range span.min_age"
    And I should see "12" within "table.full_width tr.org td.org_age_range span.max_age"
    And I should see "Jim Contact" within "table.full_width tr.org td.org_contact_info span.org_contact"
    And I should see "805-555-1212" within "table.full_width tr.org td.org_contact_info span.org_contact_phone"
    And I should see "Camp DoYaWanna" within "table.full_width tr.org td.org_name"
    And I should see "Add a new organization" within "a"
    
  @orgs_edit @admin_orgs_edit
  Scenario: Editing an Organization
    When I go to the admin orgs page
    And I follow "Camp TittiCaca"
    Then I should be on the Edit Organization page for "Camp TittiCaca" 
    And I should see "Edit Organization: Camp TittiCaca"
    And the "org_name" field should contain "Camp TittiCaca"
    And the "org_description" field should contain "Camp TittiCaca sits"
    And the "org_blurb" field should contain "A camp for a new generation" 
    And the "org_min_age" field should contain "5"
    And the "org_max_age" field should contain "9"
    And the "org_contact" field should contain "Jim Contact"
    And the "org_contact_phone" field should contain "805-555-1212"
    And the "org_contact_email" field should contain "jim@camptitticaca.com"
                
  @orgs_update @admin_org_update @valid
  Scenario: Updating an Organization with Valid Data
    Given I am on the Edit Organization page for "Camp TittiCaca" 
    When I fill in "org_blurb" with "Something that wouldn't be in the database already by coincidence"
    And I press "Save Changes"
    Then I should be on the admin orgs page
    And I should see "You have successfully updated the organization."
    And I should see "Something that wouldn't be in the database already by coincidence" within "td.org_blurb"
  
  @org_update @admin_org_update @invalid
  Scenario: Updating an Organization with Invalid Data
    Given I am on the Edit Organization page for "Camp TittiCaca" 
    When I fill in "org_description" with ""
    And I press "Save Changes"
    Then I should be on the Organization page for "Camp TittiCaca"
    And I should see "can't be blank"

  @org_destroy
  Scenario: Destroying an Organization record
    Given I am on the admin orgs page
    When I follow "Delete"
    # The non-scenario, at least until we have gracefully degrading destroy and/or Selenium
    
  Scenario: Starting to Add a New Org
    When I go to the admin orgs page
    And I follow "Add a new organization"
    Then I should be on the admin new org page
    And I should see "Add a New Organization" within "h1"
    And I am on the admin new org page
    Then I should see labels "Name of Organization, Gender, Description, Blurb, Age Range, Address, City, State, Zip Code, Main Contact, Main Contact Phone, Main Contact Email" within "fieldset#org_fields dl dt"
    And I should see inputs "org_name, org_min_age, org_max_age, org_address, org_city, org_zip, org_contact, org_contact_phone, org_contact_email" within "fieldset#org_fields dl dd"
    And I should see selects "org_gender, org_state, org_owner_id" within "fieldset#org_fields dl dd"
    And I should see textareas "org_description, org_blurb" within "fieldset#org_fields dl dd" 
    
  Scenario: Adding a New Org with missing data
    Given no org records
    When I go to the admin new org page
    And I press "Create"
    Then I should be on the admin orgs page
    And I should see "can't be blank" within "div#errorExplanation"
    
  Scenario: Adding a New Org with valid data
    Given no org records
    Given the following person record
      | first_name | last_name | email        | phone      | address1     | city | state | zip   |
      | Orgo       | Owner     | orgo@org.org | 8055551212 | 1234 My Ave. | SB   | CA    | 93101 |
    When I go to the admin new org page
    And I fill in "org_name" with "Camp Valid"
    And I select "boys" from "org_gender"
    And I fill in "org_description" with "This camp is great."
    And I fill in "org_blurb" with ""
    And I fill in "org_min_age" with "9"
    And I fill in "org_max_age" with "12"
    And I fill in "org_contact" with "Camp Contact"
    And I fill in "org_contact_phone" with "805-555-1212"
    And I fill in "org_contact_email" with "info@campvalid.org"
    And I fill in "org_address" with "1234 Any St."
    And I fill in "org_city" with "Santa Barbara"
    And I select "California" from "org_state"
    And I fill in "org_zip" with "93101"
    And I select "Orgo Owner" from "org_owner_id"
    And I press "Create"
    Then I should be on the admin orgs page
    And I should see "Camp Valid"