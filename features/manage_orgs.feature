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
  
  Scenario: Viewing Organizations
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
    When I go to the admin orgs page
    Then I should see "Organizations" within "h1"
    Then I should see "Camp TittiCaca" within "ul#organizations_list li.organizations_list_item h2"
    And I should see "Camp TittiCaca sits nestled in the forests" within "ul li p"
    And I should see "A camp for a new generation" within "ul li p"
    And I should see "9" within "ul li span#min_age"
    And I should see "12" within "ul li span#max_age"
    And I should see "Jim Contact" within "dl dt"
    And I should see "805-555-1212" within "dl dd"
    And I should see "Camp DoYaWanna" within "ul#organizations_list li.organizations_list_item h2"
    And I should see "Add a New Organization" within "a"

  Scenario: Starting to Add a New Org
    When I go to the admin orgs page
    And I follow "Add a New Organization"
    Then I should be on the admin new org page
    And I should see "Add a New Organization" within "h1"
    And I am on the admin new org page
    Then I should see labels "Name of Organization, Gender, Description, Blurb, Age Range, Address, City, State, Zip Code, Main Contact, Main Contact Phone, Main Contact Email" within "fieldset#org_fields dl dt"
    And I should see inputs "org_name, org_min_age, org_max_age, org_address, org_city, org_zip, org_contact, org_contact_phone, org_contact_email" within "fieldset#org_fields dl dd"
    And I should see selects "org_gender, org_state, org_owner_id" within "fieldset#org_fields dl dd"
    And I should see textareas "org_description, org_blurb" within "fieldset#org_fields dl dd" 
    #####   This commented-out stuff will almost assuredly be removed, as it relied on the 
    #####   OrgOwner < Person class that no longer exists
    # Then I should see labels "First name, Last name, Address, City, State, Zip, Email, Re-enter email, Password, Re-enter password" within "fieldset#org_owner_fields dl dt"
    # And I should see inputs "org_org_owner_attributes_first_name, org_org_owner_attributes_last_name, org_org_owner_attributes_phone, org_org_owner_attributes_address1, org_org_owner_attributes_city, org_org_owner_attributes_zip, org_org_owner_attributes_email, org_org_owner_attributes_email_confirmation, org_org_owner_attributes_user_attributes_password, org_org_owner_attributes_user_attributes_password_confirmation" within "fieldset#org_owner_fields dl dd"
    # And I should see selects "org_org_owner_attributes_state" within "fieldset#org_owner_fields dl dd"
    
  Scenario: Adding a New Org with missing data
    Given no org records
    When I go to the admin new org page
    And I press "Create Organization"
    Then I should be on the admin orgs page
    And I should see "can't be blank" within "div#errorExplanation"
    
  Scenario: Adding a New Org with valid data
    Given no org records
    Given the following person record
      | first_name | last_name | email        | phone      | address1     | city | state | zip   |
      | Orgo       | Owner     | orgo@org.org | 8055551212 | 1234 My Ave. | SB   | CA    | 93101 |
    When I go to the admin new org page
    # And I fill in every org field with valid org data
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
    And I press "Create Organization"
    Then I should be on the admin orgs page
    And I should see "Camp Valid" within "ul#organizations_list li.organizations_list_item h2"