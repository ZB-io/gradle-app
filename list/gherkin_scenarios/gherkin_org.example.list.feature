Feature: LinkedList Operations
  As a user of the LinkedList class
  I want to perform operations like add, remove, and get elements
  So that I can manage a collection of strings efficiently

  Background:
    Given I have an empty linked list

  Scenario: Creating a new linked list
    Then the list should be empty
    And the size of the list should be 0

  Scenario: Adding elements to the list
    When I add "one" to the list
    Then the size of the list should be 1
    And the element at index 0 should be "one"
    When I add "two" to the list
    Then the size of the list should be 2
    And the element at index 1 should be "two"

  Scenario: Removing existing elements from the list
    Given I have added "one" to the list
    And I have added "two" to the list
    When I remove "one" from the list
    Then the removal should be successful
    And the size of the list should be 1
    And the element at index 0 should be "two"
    When I remove "two" from the list
    Then the removal should be successful
    And the list should be empty

  Scenario: Removing non-existing elements from the list
    Given I have added "one" to the list
    And I have added "two" to the list
    When I try to remove "three" from the list
    Then the removal should fail
    And the size of the list should be 2

  Scenario: Accessing elements by index
    Given I have added "one" to the list
    And I have added "two" to the list
    When I get the element at index 0
    Then I should receive "one"
    When I get the element at index 1
    Then I should receive "two"

  Scenario: Accessing elements with invalid index
    Given I have an empty linked list
    When I try to get an element at index 0
    Then I should get an index out of bounds exception
