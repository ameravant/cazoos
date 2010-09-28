@categories
Feature: Org Categories

  Before do
    Given no user records
    Given the following user record
      | login | email           | password | password_confirmation |
      | admin | admin@admin.org | admin    | admin                 |
  end

  Scenario: Visiting the Categories Page
    Given I am logged in as "admin" with password "admin"  
    Given the following org_category records
      | title            |
      | Horseback Riding |
      | Archery          |
    When I go to the Organization Categories page
    Then I should see "Organization Categories" within "h1"
    And I should see "Horseback Riding" within "dl#org_categories_list dt"
    And I should see "Archery" within "dl#org_categories_list dt"    
        
  Scenario: Adding a New Category
    Given I am logged in as "admin" with password "admin"  
    Given I am on the Organization Categories page
    When I follow "Add a New Category"
    Then I should be on the New Organization Category page
    And I should see "Add a New Organization Category" within "h1"
    And I should see "Title" within "form dl dt"
    And I should see inputs "org_category_title" within "form dl dd"
    When I fill in "Hiking" for "org_category_title"
    And I press "Create"
    Then I should be on the Organization Categories page
    And I should see "The new organization category was successfully created."
    And I should see "Hiking" within "dl#org_categories_list dt"
    
  # This is a controller test more than a model test, as the validation is tested in spec/models
  Scenario: Adding a New Category with a blank title
    Given I am logged in as "admin" with password "admin"  
    Given I am on the New Organization Category page
    And I press "Create"
    Then I should be on the Organization Categories page
    And I should see "can't be blank"  
    
  # Consider the following Scenario: Adding a category with a duplicate name
  #     give warning/prompt for certainty before making potential duplicate
  
  Scenario: Editing a Category
    Given I am logged in as "admin" with password "admin"  
    Given the following org_category records
      | title            |
      | Horseback Riding |
    Given I am on the Organization Categories page
    When I follow "Edit" within "dd" 
    Then I should be on the Edit Organization Category page for "Horseback Riding"
    And I should see "Edit Category: Horseback Riding" within "h1"
    And the "org_category_title" field should contain "Horseback Riding" 
    When I fill in "org_category_title" with "Beginning Horseback Riding"
    And I press "Save Changes"
    Then I should be on the Organization Categories page
    And I should see "Beginning Horseback Riding" within "dl#org_categories_list dt"
    And I should see "The category was successfully updated."
    
  Scenario: Updating a Category with a blank title  
    Given I am logged in as "admin" with password "admin"  
    Given the following org_category records
      | title            |
      | Horseback Riding |
    Given I am on the Edit Organization Category page for "Horseback Riding"
    When I fill in "org_category_title" with ""
    And I press "Save Changes"
    Then I should be on the Organization Category page for "Horseback Riding"
    And I should see "can't be blank" within "div#errorExplanation"
    
  # There is currently no check for links to this category or dependencies on it
  Scenario: Deleting a Category
    Given I am logged in as "admin" with password "admin"  
    Given the following org_category records
      | title            |
      | Horseback Riding |
    Given I am on the Organization Categories page
    Then I should see "Horseback Riding"
    When I follow "Delete"
    Then I should be on the Organization Categories page
    And I should see "The 'Horseback Riding' category was successfully deleted."
    And I should not see "Horseback Riding" within "dl#org_categories_list"
    