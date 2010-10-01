@org_types
Feature: Org Types

  Background:
    Given I am logged in as "admin" with password "admin"  

  @org_types_index
  Scenario: Visiting the Organization Types Admin Page
    Given the following org_type records
      | title       | description                |
      | Summer Camp | Description of Summer Camp |
      | School      | Description of School      |
    When I go to the Organization Types Admin page
    Then I should see "Organization Types" within "h1"
    And I should see "Summer Camp" within "table#org_types.full_width tr td.org_type_title"
    And I should see "School" within "table#org_types.full_width tr td.org_type_title"
    When I follow "View Organizations"
    Then I should be on the Organizations Admin page
        
  @org_type_create @valid
  Scenario: Adding a New Organization Type
    Given I am on the Organization Types Admin page
    When I follow "Add a new organization type"
    Then I should be on the New Organization Type page
    And I should see "Add a New Organization Type" within "h1"
    And I should see "Title" within "form dl dt"
    And I should see inputs "org_type_title" within "form dl dd.form-option"
    When I fill in "After-School Program" for "org_type_title"
    And I fill in "Some description of some stuff" for "org_type_description"
    And I press "Create"
    Then I should be on the Organization Types Admin page
    And I should see "The new organization type was successfully created."
    And I should see "After-School Program" within "table#org_types.full_width tr td.org_type_title"
    
  # This is a controller test more than a model test, as the validation is tested in spec/models
  Scenario: Adding a New Type with a blank title
    # Given I am logged in as "admin" with password "admin"  
    Given I am on the New Organization Type page
    And I press "Create"
    Then I should be on the Organization Types Admin page
    And I should see "can't be blank"  
    
  # Consider the following Scenario: Adding a category with a duplicate name
  #     give warning/prompt for certainty before making potential duplicate
  
  @org_type_edit @valid
  Scenario: Editing a Category
    Given the following org_type records
      | title       | description                |
      | School      | Description of School      |
    Given I am on the Organization Types Admin page
    When I follow "School" 
    Then I should be on the Organization Type Edit page for "School"
    And I should see "Edit Organization Type: School" within "h1"
    And the "org_type_title" field should contain "School" 
    When I fill in "org_type_title" with "Private School"
    And I press "Save Changes"
    Then I should be on the Organization Types Admin page
    And I should see "Private School"
    And I should see "The organization type was successfully updated."
    
  @org_type_edit @invalid
  Scenario: Updating an Organization Type with a blank title  
    Given the following org_type records
      | title       | description                |
      | School      | Description of School      |
    Given I am on the Organization Type Edit page for "School"
    When I fill in "org_type_title" with ""
    And I press "Save Changes"
    Then I should be on the Organization Type page for "School"
    And I should see "can't be blank" within "div#errorExplanation"
    
  # There is currently no check for links to this Type or dependencies on it, something to consider later
  # Also, without Selenium we will not be able to run this scenario, 
  # b/c we do not have a gracefully degrading version of it.  Perhaps something to consider later.
  # Scenario: Deleting an Organization Type
  #   Given the following org_category records
  #     | title    | description  |
  #     | School   | Some desc... |
  #   Given I am on the Organization Types Admin page
  #   Then I should see "School"
  #   When I follow "Delete"
  #   Then I should be on the Organization Types Admin page
  #   And I should see "The 'School' type was successfully deleted."
  #   And I should not see "School"