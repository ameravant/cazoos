@activities
Feature: Adding an activity
  In order to have activities for org owners to choose from
  As an admin 
  I want add new activities to the system
  
  Background:
    Given the following activity_category records
      | name | description |
      | Fun | Sessions that are for amusement |
      | Educational | Sessions that teach something valuable |
    Given the following activity records
      | name                 | description                                                 |
      | Horseback Riding 101 | Beginning Horseback Riding, perfect for ages 9-13...        |
      | Archery              | For the child who likes to push him/herself, concentrate... |
    Given the following org record
      | name       |
      | Camp Valid |
    Given I am logged in as the owner of "Camp Valid" with password "secret"
      
  @activities_index  
  Scenario Outline: Vising the Activities Admin page
    Given I am on the Activities Admin page
    Then I should see "Activities" within "h1"
    And I should see "Horseback Riding 101" within "table#activities.full_width tr.activity td.activity_name"
    When I follow <link> 
    Then I should be on <destination>
    Examples:
      | link                       | destination                                       |
      | "View Activity Categories" | the Activity Categories Admin page                |
      | "Horseback Riding 101"     | the Activity Edit page for "Horseback Riding 101" |
      | "Add an activity"          | the New Activity page                             |
  
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