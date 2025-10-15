Feature: Hello Servlet API Integration Tests
  As a user of the Hello Servlet API
  I want to verify the GET and POST endpoints
  So that I can ensure the API is working correctly

  Scenario: Successfully get greeting message from HelloServlet
    Given the HelloServlet is deployed and running at "http://localhost:8080"
    When I send a GET request to "/HelloServlet"
    Then the response status code should be 200
    And the response body should contain "Hello! Is Gradle working for you?"
    And the response should include a newline character

  Scenario: Successfully post to HelloServlet endpoint
    Given the HelloServlet is deployed and running at "http://localhost:8080"
    When I send a POST request to "/HelloServlet"
    Then the response status code should be 200 
    And the response body should contain "Hello! Is Gradle working for you?"
    And the response should include a newline character

  Scenario: Get request to non-existent servlet path returns 404
    Given the HelloServlet is deployed and running at "http://localhost:8080"
    When I send a GET request to "/NonExistentServlet"
    Then the response status code should be 404

  Scenario: Post request to non-existent servlet path returns 404
    Given the HelloServlet is deployed and running at "http://localhost:8080"
    When I send a POST request to "/NonExistentServlet" 
    Then the response status code should be 404

  Scenario: Get request with malformed servlet URL returns 400
    Given the HelloServlet is deployed and running at "http://localhost:8080"
    When I send a GET request to "/HelloServlet/%"
    Then the response status code should be 400

  Scenario: Post request with malformed servlet URL returns 400
    Given the HelloServlet is deployed and running at "http://localhost:8080"
    When I send a POST request to "/HelloServlet/%" 
    Then the response status code should be 400

  Scenario: Verify POST request calls doGet internally
    Given the HelloServlet is deployed and running at "http://localhost:8080"
    When I send a POST request to "/HelloServlet"
    Then the response status code should be 200
    And the response body should be identical to the GET request response
    And the response body should contain "Hello! Is Gradle working for you?"
    And the response should include a newline character
