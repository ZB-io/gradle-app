Feature: Customer Management API

  Scenario: Retrieve all customers
    Given the API base URL is "http://localhost:8080"
    When I send a GET request to "/api/customers"
    Then the response status should be 200
    And the response body should contain a list of customers
    And the CustomerController's getAllCustomers method should be called

  Scenario: Retrieve a specific customer by ID
    Given the API base URL is "http://localhost:8080"
    And a customer with ID 1 exists in the system
    When I send a GET request to "/api/customers/1"
    Then the response status should be 200
    And the response body should contain the customer details with ID 1
    And the customer name should be present in the response
    And the CustomerController's getCustomerById method should be called with ID 1

  Scenario: Retrieve a non-existent customer
    Given the API base URL is "http://localhost:8080"
    And no customer with ID 999 exists in the system
    When I send a GET request to "/api/customers/999"
    Then the response status should be 404
    And the response body should be empty
    And the CustomerController's getCustomerById method should be called with ID 999

  Scenario: Create a new customer
    Given the API base URL is "http://localhost:8080"
    And I have the following customer details:
      | name      | John Doe        |
      | email     | john@example.com|
      | address   | 123 Main St     |
    When I create a Customer object with the provided details
    And I send a POST request to "/api/customers" with the Customer object in the request body
    Then the response status should be 201
    And the response body should contain the created customer with an ID
    And the CustomerController's createCustomer method should be called once

  Scenario: Create a new customer with invalid data
    Given the API base URL is "http://localhost:8080"
    And I have the following invalid customer details:
      | name      |                 |
      | email     | invalid-email   |
      | address   | 123 Main St     |
    When I create a Customer object with the provided details
    And I send a POST request to "/api/customers" with the Customer object in the request body
    Then the response status should be 400
    And the response should contain validation error messages

  Scenario: Create a new customer with duplicate email
    Given the API base URL is "http://localhost:8080"
    And a customer with email "john@example.com" already exists in the system
    And I have the following customer details:
      | name      | Jane Doe        |
      | email     | john@example.com|
      | address   | 456 Oak St      |
    When I create a Customer object with the provided details
    And I send a POST request to "/api/customers" with the Customer object in the request body
    Then the response status should be 409
    And the response should contain a message indicating the email is already in use

  Scenario: Delete an existing customer
    Given the API base URL is "http://localhost:8080"
    And a customer with ID 2 exists in the system
    When I send a DELETE request to "/api/customers/2"
    Then the response status should be 204
    And the customer with ID 2 should no longer exist in the system
    And the CustomerController's deleteCustomer method should be called with ID 2
    And the CustomerService's deleteCustomer method should be called with ID 2

  Scenario: Delete a non-existent customer
    Given the API base URL is "http://localhost:8080"
    And no customer with ID 888 exists in the system
    When I send a DELETE request to "/api/customers/888"
    Then the response status should be 404
    And the CustomerController's deleteCustomer method should be called with ID 888
    And the CustomerService's deleteCustomer method should throw a ResourceNotFoundException

  Scenario: Validate customer details retrieved by ID
    Given the API base URL is "http://localhost:8080"
    And a customer with the following details exists:
      | id        | 5               |
      | name      | Jane Smith      |
      | email     | jane@example.com|
      | address   | 456 Oak Avenue  |
    When I send a GET request to "/api/customers/5"
    Then the response status should be 200
    And the response body should contain a customer with name "Jane Smith"
    And the response body should contain a customer with email "jane@example.com"
    And the response body should contain a customer with address "456 Oak Avenue"
    And the CustomerController's getCustomerById method should be called with ID 5
