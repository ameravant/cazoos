@activities
Feature: Adding an activity
  In order to have activities for org owners to choose from
  As an admin 
  I want add new activities to the system
  
  Background:
    Given the following activity_category records
      | name        | description                            |
      | Fun         | Sessions that are for amusement        |
      | Educational | Sessions that teach something valuable |
    Given the following activity records
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
      
  @activities_index  
  Scenario Outline: Visiting the Activities Admin page as Various Types of People
    Given I am logged in as <login> with password <password>
    Given I am on the homepage
    When I go to the Activities Admin page
    Then I should be on <should_be_on>
    Then I should <only_admin> see "Activities" within "h1"
    And I should <only_admin> see "Horseback Riding 101"
    And I should <if_logged_in_but_not_admin> see "do not have access"
    And I should not see "Add an activity" within "a"
    Examples:
      | login                                                 | password | should_be_on              | only_admin | if_logged_in_but_not_admin |
      | "admin"                                               | "admin"  | the Activities Admin page |            | not                        |
      | the owner of the Org that owns "Horseback Riding 101" | "secret" | the homepage              | not        |                            |
      | person with email "parent@home.com"                   | "secret" | the homepage              | not        |                            |
      | "anonymous"                                           | "bogus"  | the login page            | not        | not                        |
  
  @activities_index    
  Scenario Outline: Leaving the Activities Admin page
    Given I am logged in as "admin" with password "admin"
    And I am on the Activities Admin page
    When I follow <link> 
    Then I should be on <destination>
    Examples:
      | link                       | destination                                       |
      | "View Activity Categories" | the Activity Categories Admin page                |
      | "Horseback Riding 101"     | the Activity Edit page for "Horseback Riding 101" |

  @org_activities_index
  Scenario Outline: Visiting the Activities Admin page for a particular Org
    Given I am logged in as <login> with password <password>
    When I go to the Activities Admin page for the Org with "Horseback Riding 101"
    Then I should be on <should_be_on>
    And I should <owner_or_admin> see "Horseback Riding 101"
    Examples:
      | login                                                 | password | should_be_on                                                      | owner_or_admin | 
      | "admin"                                               | "admin"  | the Activities Admin page for the Org with "Horseback Riding 101" |                | 
      | the owner of the Org that owns "Horseback Riding 101" | "secret" | the Activities Admin page for the Org with "Horseback Riding 101" |                | 
      | the owner of the Org that owns "Archery"              | "secret" | the homepage                                                      | not            | 
      | "anonymous"                                           | "bogus"  | the login page                                                    | not            | 
    
  @org_activities_index
  Scenario Outline: Leaving the Activities Admin page for a particular Org (as SuperAdmin)
    Given I am logged in as "admin" with password "admin"
    And I am on the Activities Admin page for the Org with "Horseback Riding 101"
    When I follow <link>
    Then I should be on <destination>
    Examples:
      | link                       | destination                                       |
      | "View Activity Categories" | the Activity Categories Admin page                |
      | "Horseback Riding 101"     | the Activity Edit page for "Horseback Riding 101" |
      | "Add an activity"          | the New Activity page for the Org with "Horseback Riding 101" |

  @org_activities_index
  Scenario: Leaving the Activities Admin page for a particular Org (as Org Owner)
    Given I am logged in as the owner of the Org that owns "Horseback Riding 101" with password "secret"
    And I am on the Activities Admin page for the Org with "Horseback Riding 101"
    Then I should not see "View Activity Categories" within "a"
    Then I should not see "Add an Activity" within "a"
    When I follow "Horseback Riding 101"
    Then I should be on the Activity Edit page for "Horseback Riding 101"
  
  @activity_edit
  Scenario: Editing an Activity
    Given I am on the Activity Edit page for "Horseback Riding 101"
    Then I should see "Edit Activity: Horseback Riding 101" within "h1"
    Then the "activity_name" field should contain "Horseback Riding 101"
    And the "activity_description" field should contain "Beginning Horseback Riding, perfect for ages 9-13"
    And I should see labels "Fun, Educational" within "fieldset#activity_categories"
    And the "Fun" checkbox within "fieldset#activity_categories" should not be checked
    And the "Educational" checkbox within "fieldset#activity_categories" should not be checked
    
  @activity_update
  Scenario: Updating an Activity
    Given I am on the Activity Edit page for "Horseback Riding 101"
    When I check "Fun"
    And I fill in "Horseback Riding 102" for "Name"
    And I press "Save Changes"
    Then I should be on the Activities Admin page
    And I should see "Activity has been successfully updated."
    When I follow "Horseback Riding 102"
    Then the "Fun" checkbox within "fieldset#activity_categories" should be checked
    And the "Educational" checkbox within "fieldset#activity_categories" should not be checked

  @activity_update @invalid
  Scenario: Updating an Activity with Invalid Data followed by Corrections
    Given I am on the Activity Edit page for "Horseback Riding 101"
    When I fill in "" for "Name"
    And I press "Save Changes"
    Then I should be on the Activity page for "Horseback Riding 101"
    And I should not see "Activity has been successfully updated."
    And I should see "Name can't be blank"
    When I fill in "Horseback and Sundries" for "Name"
    And I check "Fun"
    And I press "Save Changes"
    Then I should be on the Activities Admin page
    And I should see "Horseback and Sundries" within "table#activities.full_width tr.activity td.activity_name"
    When I follow "Horseback and Sundries"
    Then the "Fun" checkbox should be checked
    
  @activity_create
  Scenario: Creating a New Activity
    Given I am on the New Activity page
    Then the "Fun" checkbox within "fieldset#activity_categories" should not be checked
    And the "Educational" checkbox within "fieldset#activity_categories" should not be checked
    When I fill in "Cliff Diving" for "Name"
    And I fill in "The most exhilarating thing you'll ever try!" for "Description"
    And I check "Educational"
    And I press "Create"
    Then I should be on the Activities Admin page
    And I should see "New Activity successfully created."
    When I follow "Cliff Diving" within "table#activities.full_width tr.activity td.activity_name"
    Then I should be on the Activity Edit page for "Cliff Diving"
    And the "Educational" checkbox within "fieldset#activity_categories" should be checked
  
  @activity_create @invalid
  Scenario: Creating a New Activity with Invalid Data followed by Corrections
    Given I am on the New Activity page
    When I fill in "Cliff Diving" for "Name"
    And I check "Educational"
    And I press "Create"
    Then I should be on the Activities Admin page
    And I should see "Description can't be blank"
    And the "Educational" checkbox should be checked
    When I fill in "Description" with "A valid description"
    And I press "Create"
    Then I should be on the Activities Admin page
    And I should see "New Activity successfully created."