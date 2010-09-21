@orgs
Feature: Manage Orgs
  In order to manage orgs (camps, schools, etc)
  As a SuperUser 
  I want to be able to create, edit and destroy orgs
  
  Scenario: Viewing Organizations
    Given I am logged in as "admin" with password "admin"
    Given the following org records
      | name           | description                                                                                  | blurb                       | min_age | max_age |
      | Camp TittiCaca | Camp TittiCaca sits nestled in the forests in California's beautiful Yosemite National Park. | A camp for a new generation | 9       | 12      |
      | Camp DoYaWanna | Camp DoYaWanna is full of hard-to-resist fun activities that will leave your child happy...  | Camp for hyperactive children  | 5       | 9       |
    When I go to the admin orgs page
    Then I should see "Organizations" within "h1"
    Then I should see "Camp TittiCaca" within "ul#organizations_list li.organizations_list_item h2"
    And I should see "Camp TittiCaca sits nestled in the forests" within "ul li p"
    And I should see "A camp for a new generation" within "ul li p"
    And I should see "9" within "ul li span#min_age"
    And I should see "12" within "ul li span#max_age"
    And I should see "Camp DoYaWanna" within "ul#organizations_list li.organizations_list_item h2"
    And I should see "Add a New Organization" within "a"

  Scenario: Starting to Add a New Org
    Given I am logged in as "admin" with password "admin"
    # Given the following org_owner records
    #   | first_name | last_name  | email              |
    #   | Camp       | Owner      | campowner@camp.com |
    #   | School     | Proprietor | jim@school.com     |
    When I go to the admin orgs page
    And I follow "Add a New Organization"
    Then I should be on the admin add org page
    And I should see "Add a New Organization" within "h1"
    And I am on the admin add org page
    # Then I should see "Owner, Camp" within "select#org_owners_list option.org_owner"
    Then I should see labels Name of Organization
    # And I should see a field with id org_name