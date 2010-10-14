@events
Feature: Managing Events

  Background:
    Given the following activity records
      | name                 | description                                                 |
      | Horseback Riding 101 | Beginning Horseback Riding, perfect for ages 9-13...        |
      | Archery              | For the child who likes to push him/herself, concentrate... |
  
  Scenario: Creating an Event as an Org Owner
    Given I am logged in as the owner of the Org that owns "Horseback Riding 101" with password "secret"
    When I am on the Events Admin page for the Activity "Horseback Riding 101"
