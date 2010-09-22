@orgs
Feature: Manage Orgs
  In order to manage orgs (camps, schools, etc)
  As a SuperUser 
  I want to be able to create, edit and destroy orgs
  
  Scenario: Viewing Organizations
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
    Given I am logged in as "admin" with password "admin"
    When I go to the admin orgs page
    And I follow "Add a New Organization"
    Then I should be on the admin add org page
    And I should see "Add a New Organization" within "h1"
    And I am on the admin add org page
    Then I should see labels "Name of Organization, Gender, Description, Blurb, Age Range, Address, City, State, Zip Code, Main Contact, Main Contact Phone, Main Contact Email" within "fieldset#org_fields dl dt"
    Then I should see labels "First name, Last name, Address, City, State, Zip, Email, Re-enter email, Password, Re-enter password" within "fieldset#org_owner_fields dl dt"
    And I should see inputs "org_name, org_gender, org_description, org_blurb, org_min_age, org_max_age, org_address, org_city, org_state, org_zip, org_contact, org_contact_phone, org_contact_email" within "fieldset#org_fields dl dd" 
    And I should see inputs "org_org_owner_attributes_first_name, org_org_owner_attributes_first_name, org_org_owner_attributes_last_name, org_org_owner_attributes_phone, org_org_owner_attributes_address1, org_org_owner_attributes_city, org_org_owner_attributes_state, org_org_owner_attributes_zip, org_org_owner_attributes_email, org_org_owner_attributes_email_confirmation, org_org_owner_attributes_user_attributes_password, org_org_owner_attributes_user_attributes_password_confirmation" within "fieldset#org_owner_fields dl dd"
    
  Scenario: Adding a New Org
    Given no org records
    Given I am logged in as "admin" with password "admin"
    When I go to the admin add org page
    # And I fill in "org_name" with ""
    # Then I should see "Add"

    # Examples:
    #    | org_name
 



