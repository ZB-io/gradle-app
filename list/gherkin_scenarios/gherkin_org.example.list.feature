Feature: LinkedList Operations
  As a developer
  I want to use a LinkedList data structure
  So that I can store and manipulate a collection of string elements

  Background:
    Given a new empty LinkedList is created

  Scenario: Create an empty LinkedList
    Then the list size should be 0

  Scenario: Add a single element to an empty list
    When I add element "one" to the list
    Then the list size should be 1
    And the element at index 0 should be "one"

  Scenario: Add multiple elements to the list
    When I add element "one" to the list
    And I add element "two" to the list
    And I add element "three" to the list
    Then the list size should be 3
    And the element at index 0 should be "one"
    And the element at index 1 should be "two"
    And the element at index 2 should be "three"

  Scenario: Remove an existing element from the list
    Given the list contains elements "one,two,three"
    When I remove element "two" from the list
    Then the remove operation should return true
    And the list size should be 2
    And the element at index 0 should be "one"
    And the element at index 1 should be "three"

  Scenario: Remove the first element from the list
    Given the list contains elements "one,two,three"
    When I remove element "one" from the list
    Then the remove operation should return true
    And the list size should be 2
    And the element at index 0 should be "two"

  Scenario: Remove the last element from the list
    Given the list contains elements "one,two,three"
    When I remove element "three" from the list
    Then the remove operation should return true
    And the list size should be 2
    And the element at index 1 should be "two"

  Scenario: Remove a non-existing element from the list
    Given the list contains elements "one,two"
    When I remove element "three" from the list
    Then the remove operation should return false
    And the list size should be 2

  Scenario: Remove all elements from the list
    Given the list contains elements "one,two"
    When I remove element "one" from the list
    And I remove element "two" from the list
    Then the list size should be 0

  Scenario: Get element at valid index
    Given the list contains elements "one,two,three"
    Then the element at index 0 should be "one"
    And the element at index 1 should be "two"
    And the element at index 2 should be "three"

  Scenario: Get element at invalid index throws exception
    Given the list contains elements "one,two"
    When I try to get element at index 5
    Then an IndexOutOfBoundsException should be thrown

  Scenario: Get element from empty list throws exception
    When I try to get element at index 0
    Then an IndexOutOfBoundsException should be thrown

  Scenario: Size of list after multiple operations
    When I add element "one" to the list
    And I add element "two" to the list
    And I remove element "one" from the list
    And I add element "three" to the list
    Then the list size should be 2
    And the element at index 0 should be "two"
    And the element at index 1 should be "three"
