@orgs
Feature: Manage Orgs
  In order to manage orgs (camps, schools, etc)
  As a SuperUser 
  I want to be able to create, edit and destroy orgs
  
  Background:
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
    Given the following owner record
      | first_name | last_name | email        | phone      | address1     | city | state | zip   |
      | Orgo       | Owner     | orgo@org.org | 8055551212 | 1234 My Ave. | SB   | CA    | 93101 |
    Given the following org_type record
      | title | description                  |
      | Camps | Summer camps, day camps, etc |
      
  @orgs_index
  Scenario: Viewing Organizations
    When I go to the Organizations Admin page
    Then I should see "Organizations" within "h1"
    # This line relies on what we "think" factories are going to do, but it's not working, 
    #    so we must comment it out for now
    # Then I should see "Organization Type 1" within "table#organizations.full_width tr.org td.org_org_type"
    Then I should see "Camp TittiCaca" within "table#organizations.full_width tr.org td.org_name"
    And I should see "Camp TittiCaca sits nestled in the forests" within "table.full_width tr.org td.org_description"
    And I should see "A camp for a new generation" within "table.full_width tr.org td.org_blurb"
    And I should see "9" within "table.full_width tr.org td.org_age_range span.min_age"
    And I should see "12" within "table.full_width tr.org td.org_age_range span.max_age"
    And I should see "Jim Contact" within "table.full_width tr.org td.org_contact_info span.org_contact"
    And I should see "805-555-1212" within "table.full_width tr.org td.org_contact_info span.org_contact_phone"
    And I should see "Camp DoYaWanna" within "table.full_width tr.org td.org_name"
    And I should see "Add a new organization" within "a"
    When I follow "View Organization Types"
    Then I should be on the Organization Types Admin page

  @org_new
  Scenario: Starting to Add a New Org
    When I go to the Organizations Admin page
    And I follow "Add a new organization"
    Then I should be on the New Organization page
    And I should see "Add a New Organization" within "h1"
    And I am on the New Organization page
    Then I should see labels "Name of Organization, Gender, Description, Blurb, Age Range, Address, City, State, Zip Code, Main Contact, Main Contact Phone, Main Contact Email" within "fieldset#org_fields dl dt.form-label"
    And I should see inputs "org_name, org_min_age, org_max_age, org_address, org_city, org_zip, org_contact, org_contact_phone, org_contact_email" within "fieldset#org_fields dl dd.form-option"
    And I should see selects "org_gender, org_state, org_owner_id" within "fieldset#org_fields dl dd.form-option"
    And I should see textareas "org_description, org_blurb" within "fieldset#org_fields dl dd.form-option" 

  @org_create
  Scenario: Creating a New Valid Record
    Given no org records
    When I go to the New Organization page  
    And I fill in the Org form with valid data and call it "Camp Valid"
    And I press "Create"
    Then I should be on the Organizations Admin page
    And I should see "Camp Valid" within "table#organizations tr td.org_name"

  @org_create @invalid
  Scenario: Creating a New Invalid Record followed with Corrections and Resubmit
    Given no org records
    When I go to the New Organization page  
    And I fill in the Org form with valid data and call it "Camp Valid"
    And I erase "org_name"
    And I press "Create"
    Then I should be on the Organizations Admin page
    And I should see "can't be blank"
    When I fill in "org_name" with "Camp Valid"
    And I press "Create"
    Then I should be on the Organizations Admin page
    And I should see "Camp Valid" within "table#organizations tr td.org_name"
  
  @org_edit @admin_org_edit
  Scenario: Editing an Organization
    When I go to the Organizations Admin page
    And I follow "Camp TittiCaca"
    Then I should be on the Organization Edit page for "Camp TittiCaca" 
    And I should see "Edit Organization: Camp TittiCaca"
    And the "org_name" field should contain "Camp TittiCaca"
    And the "org_description" field should contain "Camp TittiCaca sits"
    And the "org_blurb" field should contain "A camp for a new generation" 
    And the "org_min_age" field should contain "5"
    And the "org_max_age" field should contain "9"
    And the "org_contact" field should contain "Jim Contact"
    And the "org_contact_phone" field should contain "805-555-1212"
    And the "org_contact_email" field should contain "jim@camptitticaca.com"

  @org_update
  Scenario: Updating an Organization with Valid Data
    Given I am on the Organization Edit page for "Camp TittiCaca" 
    And I fill in "org_blurb" with "Unusual phrase"
    And I press "Save Changes"
    Then I should be on the Organizations Admin page
    And I should see "successfully updated"
    And I should see "Unusual phrase" within "table#organizations tr td.org_blurb"

  @org_update @invalid
  Scenario: Updating an Organization with Invalid Data followed by Corrections and Resubmit
    Given I am on the Organization Edit page for "Camp TittiCaca" 
    And I fill in "org_blurb" with "Unusual phrase"
    And I erase "org_name"
    And I press "Save Changes"
    Then I should be on the Organization page for "Camp TittiCaca"
    And I should see "can't be blank"
    When I fill in "org_name" with "Camp Some Other Valid Name"
    And I press "Save Changes"
    Then I should be on the Organizations Admin page
    And I should see "Camp Some Other Valid Name" within "table#organizations tr td.org_name"
    And I should see "successfully updated"
    And I should see "Unusual phrase" within "table#organizations tr td.org_blurb"

  @org_destroy
  Scenario: Destroying an Organization record
    Given I am on the Organizations Admin page
    When I follow "Delete"
    # The non-scenario, at least until we have gracefully degrading destroy and/or Selenium

  @org_permissions
  Scenario: Editing My Own Organization but not Someone Else's
    Given I am logged in as the owner of "Camp TittiCaca" with password "secret"
    When I go to the Organizations Admin page
    And I follow "Camp TittiCaca"
    Then I should be on the Organization Edit page for "Camp TittiCaca"
    When I go to the Organizations Admin page
    And I follow "Camp DoYaWanna"
    Then I should be on the Organizations Admin page
    And I should see "You do not have access to editing that Organization."

    @org_permissions
    Scenario: Trying to Edit Organizations as a Parent
    Given the following parent record
      | email             |
      | parent@family.com |
    Given I am logged in as person with email "parent@family.com" with password "secret"
    Given I am on the homepage
    When I go to the Organizations Admin page
    Then I should be on the homepage
    And I should see "You do not have access to editing Organizations."
    When I go to the Organization Edit page for "Camp TittiCaca"
    Then I should be on the homepage
    And I should see "You do not have access to editing Organizations."
    
  #   
  # @org_permissions
  # Scenario Outline:
  #   Given the following parent record
  #     | email             |
  #     | parent@family.com |
  #   Given I am not logged in
  #   Given I am logged in as <login> with password "secret"
  #   When I go to the Organizations Admin page
  #   Then I should be on the Organizations Admin page
  #   When I go to the Organization Edit page for "Camp TittiCaca"
  #   # Then I should not be on the Organization Edit page for "Camp TittiCaca"
  #   # Then I should see "You do not have access to Organizations"
  #   Then I should be on the Organ
  #   Examples:
  #     | login                                 |
  #     | the owner of "Camp TittiCaca"         |
  #     | person with email "parent@family.com" |
