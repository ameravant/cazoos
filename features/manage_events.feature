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
    Then I should see "Schedule for Horseback Riding 101" within "h1"
    And I follow "Add a new Event"
    Then I should be on the New Event page for the "Horseback Riding 101" offering
    And I should see "Schedule Horseback Riding 101" within "h1"
    And the "Name" field within "form#new_event" should contain "Horseback Riding 101"
    And the "Address" field within "form#new_event" should contain the mappable address of the Org with "Horseback Riding 101"
    And I should see datetime selects "Event Start date/time, Event End date/time" within "form#new_event"
    And the "Description" field within "form#new_event" should contain "Beginning Horseback Riding, perfect for ages 9-13..."
    And I should see "Fill this out with details about the sessions (E.g. 'Meets M-F 9am - 5pm')" within "form#new_event span#blurb_clarification.weak"
    And the "Registration Required" checkbox within "form#new_event" should be checked
    When I select datetime "July 5, 2011 09:00 am" from "Event Start date/time" within "form#new_event"
    And I select datetime "July 9, 2011 05:00 pm" from "Event End date/time" within "form#new_event"
    And I select datetime "June 15, 2011 11:59 pm" from "Registration deadline" within "form#new_event"
    And I press "Save Event"
    # Then I should be on the     