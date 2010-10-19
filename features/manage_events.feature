@events
Feature: Managing Events

  Background:
    Given the following offering records
      | name                 | description                                                 |
      | Horseback Riding 101 | Beginning Horseback Riding, perfect for ages 9-13...        |
      | Archery              | For the child who likes to push him/herself, concentrate... |
      
  # @offering_event_index @event_index
  # Scenario: Looking at an Offering
  #   Given the following event records
  #     | name                 | date_and_time       | end_date_and_time   |
  #     | Horseback Riding 101 | 2010-01-10 09:00:00 | 2010-01-14 17:00:00 |
  #   And I am on the Offering page for the Offering that event "Horseback Riding 101" belongs to
  #   Then I should see "Horseback Riding 101" within ""

  @event_create @event_new
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
    And I fill in "12" for "Registration Limit"
    And I select datetime "July 5, 2011 09:00 am" from "Event Start date/time" within "form#new_event"
    And I select datetime "July 9, 2011 05:00 pm" from "Event End date/time" within "form#new_event"
    And I select datetime "June 15, 2011 11:59 pm" from "Deadline to register" within "form#new_event"
    And the "Message to display when registration is full or past the deadline and now closed:" field should contain ""
    And I press "Save Event"
    Then I should be on the Offering page for "Horseback Riding 101" specific to its Org
  
  Scenario: Creating an Invalid Event and making Corrections
    Given I am logged in as the owner of the Org that owns "Horseback Riding 101" with password "secret"
    When I go to the New Event page for the "Horseback Riding 101" offering
    And I fill in "" for "Name"
    And I press "Save Event"
    Then I should be on the Events Admin page for the "Horseback Riding 101" offering 
    And I should not see "successfully saved"
    When I fill in the Event form with valid values 
    And I press "Save Event"
    Then I should be on the Offering page for "Horseback Riding 101" specific to its Org
    
