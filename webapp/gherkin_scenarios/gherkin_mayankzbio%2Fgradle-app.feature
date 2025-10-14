Feature: Integration tests for HelloServlet API

  Scenario: Successful GET request to HelloServlet
    Given the API base URL 'http://localhost:8080'
    When I send a GET request to '/hello'
    Then the response status should be 200
    And the response body should contain 'Hello! Is Gradle working for you?'

  Scenario: Unsuccessful GET request to an invalid endpoint
    Given the API base URL 'http://localhost:8080'
    When I send a GET request to '/invalid-endpoint'
    Then the response status should be 404

  Scenario: Successful POST request to HelloServlet
    Given the API base URL 'http://localhost:8080'
    When I send a POST request to '/hello'
    Then the response status should be 200
    And the response body should contain 'Hello! Is Gradle working for you?'

  Scenario: Handling unsupported HTTP method (DELETE)
    Given the API base URL 'http://localhost:8080'
    When I send a DELETE request to '/hello'
    Then the response status should be 405

  Scenario: Handling unsupported HTTP method (PUT)
    Given the API base URL 'http://localhost:8080'
    When I send a PUT request to '/hello'
    Then the response status should be 405
