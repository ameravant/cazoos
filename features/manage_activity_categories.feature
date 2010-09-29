@activity_categories
Feature: Manage Activity Categories

  Background:
    Given no user records
    Given the following user record
      | login | password | password_confirmation |
      | admin | admin    | admin                 |
    Given I am logged in as "admin" with password "admin"  

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
    Given I am on the Activity Categories page
    When I follow "Add a new category"
    Then I should be on the New Activity Category page
    And I should see "Add a New Activity Category" within "h1"
    And I should see "Title" within "form dl dt"
    And I should see inputs "activity_category_name" within "form dl dd"
    When I fill in "Hiking" for "activity_category_name"
    And I press "Create"
    Then I should be on the Organization Categories page
    And I should see "The new activity category was successfully created."
    And I should see "Hiking" within "table#activity_categories.full_width tr td.activity_category_name"
    
  @activity_category_create @invalid
  Scenario: Adding a New Category with a blank title
    Given I am on the New Activity Category page
    And I press "Create"
    Then I should be on the Activity Categories page
    And I should see "can't be blank"  
    
  # Consider the following Scenario: Adding a category with a duplicate name
  #     give warning/prompt for certainty before making potential duplicate
  
  @activity_category_edit @valid
  Scenario: Editing a Category
    Given the following activity_category records
      | name             | description                                             | blurb                 |
      | Horseback Riding | Providing a physical, mental and emotional challenge... | Yey, horseback riding |
    Given I am on the Activity Categories page
    When I follow "Horseback Riding" 
    Then I should be on the Edit Activity Category page for "Horseback Riding"
    And I should see "Edit Activity Category: Horseback Riding" within "h1"
    And the "activity_category_name" field should contain "Horseback Riding" 
    When I fill in "activity_category_name" with "Beginning Horseback Riding"
    And I press "Save Changes"
    Then I should be on the Activity Categories page
    And I should see "Beginning Horseback Riding"
    And I should see "The category was successfully updated."
    
  @activity_category_edit @invalid
  Scenario: Updating a Category with a blank title  
    Given the following activity_category records
      | name             | description                                             | blurb                 |
      | Horseback Riding | Providing a physical, mental and emotional challenge... | Yey, horseback riding |
    Given I am on the Edit Organization Category page for "Horseback Riding"
    When I fill in "activity_category_name" with ""
    And I press "Save Changes"
    Then I should be on the Organization Category page for "Horseback Riding"
    And I should see "can't be blank" within "div#errorExplanation"
    
  # There is currently no check for links to this category or dependencies on it, something to consider later
  # Also, without Selenium we will not be able to run this scenario, 
  # b/c we do not have a gracefully degrading version of it.  Perhaps something to consider later.
  # Scenario: Deleting an Activity Category
  #   Given the following activity_category records
  #     | title            |
  #     | Horseback Riding |
  #   Given I am on the Activity Categories page
  #   Then I should see "Horseback Riding"
  #   When I follow "Delete"
  #   Then I should be on the Activity Categories page
  #   And I should see "The 'Horseback Riding' category was successfully deleted."
  #   And I should not see "Horseback Riding"