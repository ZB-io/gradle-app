Feature: Inventory Management Functional and Non-Functional Testing

  # UI Test Scenarios: Inventory Operations & Validation

  @ui
  Scenario Outline: Add New Product with valid details
    Given I am logged in with inventory management privileges
    And I am on the Inventory page
    When I click the 'Add Product' button
    And I enter "<product_name>" in the product name field
    And I enter "<sku>" in the SKU field
    And I enter "<price>" in the price field
    And I enter "<quantity>" in the quantity field
    And I click the 'Save' button
    Then I should see a confirmation message "Product added successfully"
    And the product "<product_name>" with SKU "<sku>" appears in the inventory list with price "<price>" and quantity "<quantity>"

    Examples:
      | product_name      | sku          | price  | quantity |
      | Widget A          | WIDGET1001   | 29.99  | 15       |
      | Super Gadget      | GADG2020     | 120.00 | 5        |
      | Test Product      | TESTSKU9999  | 10.00  | 50       |

  @ui
  Scenario Outline: Reject Product Addition with missing required fields
    Given I am logged in and on the 'Add Product' page
    When I leave the "<missing_field>" field empty
    And I enter valid data in other required fields
    And I click the 'Save' button
    Then I should see a validation error message "Required field missing: <missing_field>"
    And the product is not added to the inventory

    Examples:
      | missing_field |
      | product name  |
      | SKU           |
      | price         |
      | quantity      |

  @ui
  Scenario Outline: Edit Existing Product - update price and quantity
    Given there is a product "<product_name>" in the inventory
    When I select product "<product_name>" from the inventory list
    And I click the 'Edit' button
    And I change the price to "<new_price>"
    And I change the quantity to "<new_quantity>"
    And I click the 'Update' button
    Then I should see a confirmation message "Product updated successfully"
    And the product "<product_name>" reflects price "<new_price>" and quantity "<new_quantity>" in the inventory list

    Examples:
      | product_name  | new_price | new_quantity |
      | Widget A      | 39.99     | 30           |
      | Super Gadget  | 110.00    | 7            |

  @ui
  Scenario Outline: Delete Product from Inventory
    Given the inventory list contains the product "<product_name>"
    When I select product "<product_name>" from the inventory
    And I click the 'Delete' button
    And I confirm deletion in the popup dialog
    Then I should see a confirmation message "Product deleted successfully"
    And the product "<product_name>" no longer appears in the inventory

    Examples:
      | product_name    |
      | Widget A        |
      | Obsolete Widget |

  @ui
  Scenario Outline: Search Products by Name
    Given the inventory contains multiple products with distinct names
    And I am on the Inventory page
    When I enter "<search_query>" in the search bar
    And I click the 'Search' button
    Then I should see products with names matching "<expected_result>" in the inventory list

    Examples:
      | search_query | expected_result     |
      | Widget       | Widget A, Widget B  |
      | Gadget       | Super Gadget        |
      | Test         | Test Product        |
      | Nonexistent  | No products found   |

  @ui
  Scenario Outline: Prevent addition of product with duplicate SKU
    Given there is an existing product with SKU "<existing_sku>" in the inventory
    And I am on the 'Add Product' page
    When I enter "<existing_sku>" in the SKU field
    And I fill other required fields with valid data
    And I click the 'Save' button
    Then I should see a validation error message "SKU already exists"
    And the product is not added to the inventory

    Examples:
      | existing_sku   |
      | WIDGET1001     |
      | GADG2020       |

  @ui
  Scenario Outline: Validate Price Input Format in Add Product form
    Given I have access to the 'Add Product' form
    When I enter "<invalid_price>" in the price field
    And I complete other required fields with valid data
    And I click the 'Save' button
    Then I should see a validation error message "Invalid price format"
    And the product is not added to the inventory

    Examples:
      | invalid_price |
      | abc           |
      | -10           |
      | 20,00         |
      | $50           |

  # Non-Functional UI Test Scenarios (Performance & Session Handling)

  @ui @performance
  Scenario: Inventory page load performance with maximum product count
    Given the inventory database is pre-populated with 10,000 products
    And I am logged in as an authorized user
    When I navigate to the inventory page
    Then the inventory page should load within 2 seconds
    And the UI should remain responsive

  @ui @security
  Scenario: Session timeout handling on inactivity
    Given I am logged into the inventory system
    When I remain inactive for the configured session timeout period (15 minutes)
    And I attempt to perform any action after inactivity
    Then I should be redirected to the login screen
    And I should see a session expired message
