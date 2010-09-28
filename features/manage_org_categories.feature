@categories
Feature: Org Categories

  Background:
    Given no user records
    Given the following user record
      | login | password | password_confirmation |
      | admin | admin    | admin                 |
    Given I am logged in as "admin" with password "admin"  

  Scenario: Visiting the Categories Page
    Given the following org_category records
      | title            |
      | Horseback Riding |
      | Archery          |
    When I go to the Organization Categories page
    Then I should see "Organization Categories" within "h1"
    And I should see "Horseback Riding" within "table#org_categories.full_width tr td.org_category_title"
    And I should see "Archery" within "table#org_categories.full_width tr td.org_category_title"    
        
  Scenario: Adding a New Category
    Given I am on the Organization Categories page
    When I follow "Add a new category"
    Then I should be on the New Organization Category page
    And I should see "Add a New Organization Category" within "h1"
    And I should see "Title" within "form dl dt"
    And I should see inputs "org_category_title" within "form dl dd"
    When I fill in "Hiking" for "org_category_title"
    And I press "Create"
    Then I should be on the Organization Categories page
    And I should see "The new organization category was successfully created."
    And I should see "Hiking" within "table#org_categories.full_width tr td.org_category_title"
    
  # This is a controller test more than a model test, as the validation is tested in spec/models
  Scenario: Adding a New Category with a blank title
    # Given I am logged in as "admin" with password "admin"  
    Given I am on the New Organization Category page
    And I press "Create"
    Then I should be on the Organization Categories page
    And I should see "can't be blank"  
    
  # Consider the following Scenario: Adding a category with a duplicate name
  #     give warning/prompt for certainty before making potential duplicate
  
  Scenario: Editing a Category
    Given the following org_category records
      | title            |
      | Horseback Riding |
    Given I am on the Organization Categories page
    When I follow "Horseback Riding" 
    Then I should be on the Edit Organization Category page for "Horseback Riding"
    And I should see "Edit Category: Horseback Riding" within "h1"
    And the "org_category_title" field should contain "Horseback Riding" 
    When I fill in "org_category_title" with "Beginning Horseback Riding"
    And I press "Save Changes"
    Then I should be on the Organization Categories page
    And I should see "Beginning Horseback Riding"
    And I should see "The category was successfully updated."
    
  Scenario: Updating a Category with a blank title  
    Given the following org_category records
      | title            |
      | Horseback Riding |
    Given I am on the Edit Organization Category page for "Horseback Riding"
    When I fill in "org_category_title" with ""
    And I press "Save Changes"
    Then I should be on the Organization Category page for "Horseback Riding"
    And I should see "can't be blank" within "div#errorExplanation"
    
  # There is currently no check for links to this category or dependencies on it, something to consider later
  # Also, without Selenium we will not be able to run this scenario, 
  # b/c we do not have a gracefully degrading version of it.  Perhaps something to consider later.
  # Scenario: Deleting a Category
  #   Given the following org_category records
  #     | title            |
  #     | Horseback Riding |
  #   Given I am on the Organization Categories page
  #   Then I should see "Horseback Riding"
  #   When I follow "Delete"
  #   Then I should be on the Organization Categories page
  #   And I should see "The 'Horseback Riding' category was successfully deleted."
  #   And I should not see "Horseback Riding"