Feature: Message Retrieval

  Scenario: Retrieve the default message
    Given the application is running
    When I call the getMessage method
    Then I should receive the message "hello      World!"
