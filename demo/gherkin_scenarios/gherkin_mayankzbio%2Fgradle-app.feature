Feature: Customer Management API Operations
  As a system administrator
  I want to manage customers through the CustomerController API
  So that I can maintain customer records effectively

  Background:
    Given the Customer API base URL is "http://localhost:8080/api"
    And a CustomerService instance is properly configured
    And a CustomerController instance is created with the CustomerService

  Scenario: Successfully delete an existing customer
    Given a customer exists with id 1 and following details:
      """
      {
        "id": 1,
        "name": "Alice Brown",
        "email": "alice.brown@example.com",
        "phone": "5555555555"
      }
      """
    When I send a DELETE request to "/customers/1"
    Then the response status code should be 204
    And the customer with id 1 should not exist in the system

  Scenario: Attempt to delete a non-existent customer
    Given no customer exists with id 999
    When I send a DELETE request to "/customers/999"
    Then the response status code should be 404
    And the response should contain error message "Customer not found"

  Scenario: Delete multiple customers sequentially
    Given the following customers exist in the system:
      | id | name         | email                    | phone      |
      | 1  | John Doe    | john.doe@example.com     | 1111111111 |
      | 2  | Jane Smith  | jane.smith@example.com   | 2222222222 |
      | 3  | Bob Johnson | bob.johnson@example.com  | 3333333333 |
    When I send DELETE requests to the following endpoints:
      | /customers/1 |
      | /customers/2 |
      | /customers/3 |
    Then all response status codes should be 204
    And none of the deleted customers should exist in the system

  Scenario: Delete customer and verify it cannot be retrieved
    Given a customer exists with id 5 and following details:
      """
      {
        "id": 5,
        "name": "Test User",
        "email": "test.user@example.com",
        "phone": "5555555555"
      }
      """
    When I send a DELETE request to "/customers/5"
    Then the response status code should be 204
    When I send a GET request to "/customers/5"
    Then the response status code should be 404

  Scenario: Attempt to delete customer with invalid ID format
    When I send a DELETE request to "/customers/abc"
    Then the response status code should be 400
    And the response should contain error message "Invalid customer ID format"
