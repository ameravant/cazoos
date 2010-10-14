@offerings
Feature: Adding an offering
  In order to have offerings for org owners to choose from
  As an admin 
  I want add new offerings to the system
  
  Background:
    Given the following activity_category records
      | name        | description                            |
      | Fun         | Sessions that are for amusement        |
      | Educational | Sessions that teach something valuable |
    Given the following offering records
      | name                 | description                                                 |
      | Horseback Riding 101 | Beginning Horseback Riding, perfect for ages 9-13...        |
      | Archery              | For the child who likes to push him/herself, concentrate... |
    Given the following org record
      | name       |
      | Camp Valid |
    Given the following parent record
      | email           |
      | parent@home.com |
    Given I am logged in as the owner of the Org that owns "Horseback Riding 101" with password "secret"
      
  @offerings_index  
  Scenario Outline: Visiting the Offerings Admin page as Various Types of People
    Given I am logged in as <login> with password <password>
    Given I am on the homepage
    When I go to the Offerings Admin page
    Then I should be on <should_be_on>
    Then I should <only_admin> see "Offerings" within "h1"
    And I should <only_admin> see "Horseback Riding 101"
    And I should <if_logged_in_but_not_admin> see "do not have access"
    And I should not see "Add an offering" within "a"
    Examples:
      | login                                                 | password | should_be_on              | only_admin | if_logged_in_but_not_admin |
      | "admin"                                               | "admin"  | the Offerings Admin page |            | not                        |
      | the owner of the Org that owns "Horseback Riding 101" | "secret" | the homepage              | not        |                            |
      | person with email "parent@home.com"                   | "secret" | the homepage              | not        |                            |
      | "anonymous"                                           | "bogus"  | the login page            | not        | not                        |
  
  @offerings_index    
  Scenario Outline: Leaving the Offerings Admin page (which is available only to SuperAdmin)
    Given I am logged in as "admin" with password "admin"
    And I am on the Offerings Admin page
    When I follow <link> 
    Then I should be on <destination>
    Examples:
      | link                       | destination                                       |
      | "View Activity Categories" | the Activity Categories Admin page                |
      | "Horseback Riding 101"     | the Offering Edit page for "Horseback Riding 101" |

  @org_offerings_index
  Scenario Outline: Visiting the Offerings Admin page for a particular Org
    Given I am logged in as <login> with password <password>
    When I go to the Offerings Admin page for the Org with "Horseback Riding 101"
    Then I should be on <should_be_on>
    And I should <owner_or_admin> see "Horseback Riding 101"
    Examples:
      | login                                                 | password | should_be_on                                                      | owner_or_admin | 
      | "admin"                                               | "admin"  | the Offerings Admin page for the Org with "Horseback Riding 101" |                | 
      | the owner of the Org that owns "Horseback Riding 101" | "secret" | the Offerings Admin page for the Org with "Horseback Riding 101" |                | 
      | the owner of the Org that owns "Archery"              | "secret" | the homepage                                                      | not            | 
      | "anonymous"                                           | "bogus"  | the login page                                                    | not            | 
    
  @org_offerings_index
  Scenario Outline: Leaving the Offerings Admin page for a particular Org (as SuperAdmin)
    Given I am logged in as "admin" with password "admin"
    And I am on the Offerings Admin page for the Org with "Horseback Riding 101"
    When I follow <link>
    Then I should be on <destination>
    Examples:
      | link                       | destination                                                           |
      | "View Activity Categories" | the Activity Categories Admin page                                    |
      | "Horseback Riding 101"     | the Offering Edit page for "Horseback Riding 101" specific to its Org |
      | "Add an offering"          | the New Offering page for the Org with "Horseback Riding 101"         |

  @org_offerings_index
  Scenario Outline: Leaving the Offerings Admin page for a particular Org (as Org Owner)
    Given I am logged in as the owner of the Org that owns "Horseback Riding 101" with password "secret"
    And I am on the Offerings Admin page for the Org with "Horseback Riding 101"
    Then I should not see "View Activity Categories" within "a"
    And I should see "Add an offering" within "a"
    When I follow <link>
    Then I should be on the <destination_page>
    Examples:
      | link                   | destination_page                                                  |
      | "Horseback Riding 101" | Offering Edit page for "Horseback Riding 101" specific to its Org |
      | "Add an offering"      | New Offering page for the Org with "Horseback Riding 101"         |

  @offering_edit @org_offering_edit
  Scenario Outline: Editing an Offering
    Given I am logged in as "admin" with password "admin"
    Given I am on <start_page>
    Then I should see "Edit Offering: Horseback Riding 101" within "h1"
    Then the "offering_name" field should contain "Horseback Riding 101"
    And the "offering_description" field should contain "Beginning Horseback Riding, perfect for ages 9-13"
    And I should see labels "Fun, Educational" within "fieldset#activity_categories"
    And the "Fun" checkbox within "fieldset#activity_categories" should not be checked
    And the "Educational" checkbox within "fieldset#activity_categories" should not be checked
    Examples:
      | start_page                                                            |
      | the Offering Edit page for "Horseback Riding 101"                     |
      | the Offering Edit page for "Horseback Riding 101" specific to its Org |

  @offering_edit
  Scenario: An Org Owner should not be able to get into editing an Org other than his own
    Given I am logged in as the owner of the Org that owns "Horseback Riding 101" with password "secret"
    When I go to the Offering Edit page for "Horseback Riding 101"
    Then I should be on the homepage
    And I should see "do not have access"
    When I go to the Offering Edit page for "Horseback Riding 101" specific to its Org
    Then I should be on the Offering Edit page for "Horseback Riding 101" specific to its Org
  
  @offering_update
  Scenario Outline: Updating an Offering
    Given I am logged in as "admin" with password "admin"
    Given I am on the <start_page>
    When I check "Fun"
    And I fill in "Horseback Riding 102" for "Name"
    And I press "Save Changes"
    Then I should be on the <end_page>
    And I should see "Offering has been successfully updated."
    When I follow "Horseback Riding 102"
    Then the "Fun" checkbox within "fieldset#activity_categories" should be checked
    And the "Educational" checkbox within "fieldset#activity_categories" should not be checked
    Examples:
      | start_page                                                        | end_page                                                      |
      | Offering Edit page for "Horseback Riding 101"                     | Offerings Admin page                                         |
      | Offering Edit page for "Horseback Riding 101" specific to its Org | Offerings Admin page for the Org with "Horseback Riding 102" |

  @offering_update @invalid
  Scenario Outline: Updating an Offering with Invalid Data followed by Corrections
    Given I am logged in as "admin" with password "admin"
    Given I am on the Offering Edit page for <record> 
    When I fill in "" for "Name"
    And I press "Save Changes"
    Then I should be on the Offering page for <record>
    And I should not see "Offering has been successfully updated."
    And I should see "Name can't be blank"
    When I fill in "Horseback and Sundries" for "Name"
    And I check "Fun"
    And I press "Save Changes"
    Then I should be on the Offerings Admin <page_specific_to_org_or_not>
    And I should see "Horseback and Sundries" within "table#offerings.full_width tr.offering td.offering_name"
    When I follow "Horseback and Sundries"
    Then the "Fun" checkbox should be checked
    Examples:
      | record                                     | page_specific_to_org_or_not                    |
      | "Horseback Riding 101"                     | page                                           |
      | "Horseback Riding 101" specific to its Org | page for the Org with "Horseback and Sundries" |
    
  @offering_create
  Scenario: Creating a New Offering
    Given I am on the New Offering page for the Org with "Horseback Riding 101"
    Then the "Fun" checkbox within "fieldset#activity_categories" should not be checked
    And the "Educational" checkbox within "fieldset#activity_categories" should not be checked
    When I fill in "Cliff Diving" for "Name"
    And I fill in "The most exhilarating thing you'll ever try!" for "Description"
    And I check "Educational"
    And I press "Create"
    Then I should be on the Offerings Admin page for the Org with "Horseback Riding 101"
    # And I should see "New Offering successfully created."
    When I follow "Cliff Diving" within "table#offerings.full_width tr.offering td.offering_name"
    Then I should be on the Offering Edit page for "Cliff Diving" specific to its Org
    And the "Educational" checkbox within "fieldset#activity_categories" should be checked
  
  @offering_create @invalid
  Scenario: Creating a New Offering with Invalid Data followed by Corrections
    Given I am on the New Offering page for the Org with "Horseback Riding 101"
    When I fill in "Cliff Diving" for "Name"
    And I check "Educational"
    And I press "Create"
    Then I should be on the Offerings Admin page for the Org with "Horseback Riding 101"
    And I should see "Description can't be blank"
    And the "Educational" checkbox should be checked
    When I fill in "Description" with "A valid description"
    And I press "Create"
    Then I should be on the Offerings Admin page for the Org with "Horseback Riding 101"
    # And I should see "New Offering successfully created."