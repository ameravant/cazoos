@activity_categories
Feature: Manage Activity Categories

  Background:
    Given I am logged in as "admin" with password "admin"  
    Given the following activity_category records
      | name              | description                                         | blurb           |
      | Outdoor Education | Learning all there is to know about the outdoors... | Yey, outdoor ed |

  @activity_categories_list
  Scenario: Visiting the Activity Categories Page
    Given the following activity_category records
      | name             | description                                             | blurb                 |
      | Horseback Riding | Providing a physical, mental and emotional challenge... | Yey, horseback riding |
      | Archery          | Another great way to push yourself in many ways...      | Archers rock!         |
    When I go to the Activity Categories Admin page
    Then I should see "Activity Categories" within "h1"
    And I should see "Horseback Riding" within "table#activity_categories.full_width tr td.activity_category_name"
    And I should see "Archery" within "table#activity_categories.full_width tr td.activity_category_name"    

  @activity_category_create @valid
  Scenario: Adding a New Category
    Given I am on the Activity Categories Admin page
    When I follow "Add a new category"
    Then I should be on the New Activity Category page
    And I should see "Add a New Activity Category" within "h1"
    And I should see "Name" within "form dl dt"
    And I should see inputs "activity_category_name" within "form dl dd"
    When I fill in "Hiking" for "activity_category_name"
    When I fill in "Some stuff about hiking" for "activity_category_description"
    And I press "Create"
    Then I should be on the Activity Categories Admin page
    And I should see "The new activity category was successfully created."
    And I should see "Hiking" within "table#activity_categories.full_width tr td.activity_category_name"
    
  @activity_category_create @invalid
  Scenario: Adding a New Category with a blank title
    Given I am on the New Activity Category page
    And I press "Create"
    Then I should be on the Activity Categories Admin page
    And I should see "can't be blank"  
    When I fill in "Hiking" for "activity_category_name"
    When I fill in "Some stuff about hiking" for "activity_category_description"
    And I press "Create"
    Then I should be on the Activity Categories Admin page
    And I should see "The new activity category was successfully created."
    And I should see "Hiking" within "table#activity_categories.full_width tr td.activity_category_name"
    
  # Consider the following Scenario: Adding a category with a duplicate name
  #     give warning/prompt for certainty before making potential duplicate
  
  @activity_category_edit
  Scenario: Editing an Activity Category
    Given I am on the Activity Categories Admin page
    When I follow "Outdoor Education" 
    Then I should be on the Activity Category Edit page for "Outdoor Education"
    And I should see "Edit Activity Category: Outdoor Education" within "h1"
    And the "activity_category_name" field should contain "Outdoor Education" 

  @activity_category_update
  Scenario: Updating an Activity Category with Valid Data
    Given I am on the Activity Category Edit page for "Outdoor Education"
    When I fill in "activity_category_name" with "Advanced Outdoor Education"
    And I press "Save Changes"
    Then I should be on the Activity Categories Admin page
    And I should see "Advanced Outdoor Education"
    And I should see "The activity category was successfully updated."
    
  @activity_category_update @invalid
  Scenario: Updating an Activity Category with Invalid Data followed by Corrections and Resubmit
    Given I am on the Activity Category Edit page for "Outdoor Education"
    When I fill in "activity_category_name" with ""
    And I press "Save Changes"
    Then I should be on the Activity Category page for "Outdoor Education"
    And I should see "can't be blank" within "div#errorExplanation"
    When I fill in "activity_category_name" with "Advanced Outdoor Education"
    And I press "Save Changes"
    Then I should be on the Activity Categories Admin page
    And I should see "Advanced Outdoor Education"
    And I should see "The activity category was successfully updated."

  @activity_category_destroy
  Scenario: Deleting an Activity Category
    Given I am on the Activity Categories Admin page
    When I follow "Delete"
  #   Then I should be on the Activity Categories page
  #   And I should see "The 'Horseback Riding' category was successfully deleted."
  #   And I should not see "Horseback Riding"
