Feature: Message Processing in App

  Scenario: Process and print a capitalized message
    Given the application is started
    When the message is retrieved
    And the message is split into tokens
    And the tokens are joined into a single string
    And the result is capitalized
    Then the capitalized result should be printed to the console
