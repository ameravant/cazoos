@events
Feature: Managing Events

  Background:
    Given the following offering records
      | name                 | description                                                 |
      | Horseback Riding 101 | Beginning Horseback Riding, perfect for ages 9-13...        |
      | Archery              | For the child who likes to push him/herself, concentrate... |
  
  Scenario: Creating an Event as an Org Owner
    Given I am logged in as the owner of the Org that owns "Horseback Riding 101" with password "secret"
    When I go to the Events Admin page for the "Horseback Riding 101" offering
    Then I should see "Events" within "h1"
    # And I follow "Add an event"