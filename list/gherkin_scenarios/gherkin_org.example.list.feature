Feature: LinkedList Operations
  As a developer
  I want to use a LinkedList data structure
  So that I can store and manipulate a collection of string elements

  Background:
    Given a new empty LinkedList is created

  Scenario: Create an empty LinkedList
    Then the list size should be 0

  Scenario: Add a single element to an empty list
    When I add element "first" to the list
    Then the list size should be 1
    And the element at index 0 should be "first"

  Scenario: Add multiple elements to the list
    When I add element "one" to the list
    And I add element "two" to the list
    And I add element "three" to the list
    Then the list size should be 3
    And the element at index 0 should be "one"
    And the element at index 1 should be "two"
    And the element at index 2 should be "three"

  Scenario: Remove an existing element from the list
    Given the list contains elements "apple", "banana", "cherry"
    When I remove element "banana" from the list
    Then the removal should be successful
    And the list size should be 2
    And the element at index 0 should be "apple"
    And the element at index 1 should be "cherry"

  Scenario: Remove the first element from the list
    Given the list contains elements "first", "second", "third"
    When I remove element "first" from the list
    Then the removal should be successful
    And the list size should be 2
    And the element at index 0 should be "second"

  Scenario: Remove the last element from the list
    Given the list contains elements "alpha", "beta", "gamma"
    When I remove element "gamma" from the list
    Then the removal should be successful
    And the list size should be 2
    And the element at index 1 should be "beta"

  Scenario: Remove a non-existing element from the list
    Given the list contains elements "one", "two"
    When I remove element "three" from the list
    Then the removal should fail
    And the list size should be 2

  Scenario: Remove all elements from the list one by one
    Given the list contains elements "x", "y"
    When I remove element "x" from the list
    And I remove element "y" from the list
    Then the list size should be 0

  Scenario: Get element at valid index
    Given the list contains elements "red", "green", "blue"
    When I get the element at index 1
    Then the returned element should be "green"

  Scenario: Get element at index out of bounds
    Given the list contains elements "only"
    When I try to get the element at index 5
    Then an IndexOutOfBoundsException should be thrown

  Scenario: Get element from empty list
    When I try to get the element at index 0
    Then an IndexOutOfBoundsException should be thrown

  Scenario: Remove from empty list
    When I remove element "anything" from the list
    Then the removal should fail
    And the list size should be 0

  Scenario: Add element after removing all elements
    Given the list contains elements "temp"
    When I remove element "temp" from the list
    And I add element "new" to the list
    Then the list size should be 1
    And the element at index 0 should be "new"
