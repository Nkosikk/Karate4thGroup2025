Feature: Ndosi API Registration Tests

  Background:
    * url 'https://www.ndosiautomation.co.za/API'

  Scenario: User Registration - Valid Data
    * def now = new java.util.Date().getTime()
    * def uniqueEmail = 'testuser_' + now + '@example.com'
    Given path '/register'
    And header Accept = 'application/json'
    And header Content-Type = 'application/json'
    And request
      """
      {
        "firstName": "John",
        "lastName": "Doe",
        "email": "#(uniqueEmail)",
        "password": "SecurePass123!",
        "confirmPassword": "SecurePass123!"
      }
      """
    When method POST
    Then status 201
    And match response contains { success: true }

  Scenario: User Registration - Missing Required Fields
    Given path '/register'
    And header Accept = 'application/json'
    And header Content-Type = 'application/json'
    And request
      """
      {
        "firstName": "John",
        "email": "john.doe@example.com"
      }
      """
    When method POST
    Then status 400

  Scenario: User Registration - Password Mismatch
    Given path '/register'
    And header Accept = 'application/json'
    And header Content-Type = 'application/json'
    And request
      """
      {
        "firstName": "John",
        "lastName": "Doe",
        "email": "john.doe@example.com",
        "password": "SecurePass123!",
        "confirmPassword": "DifferentPass123!"
      }
      """
    When method POST
    Then status 400

  Scenario: User Registration - Invalid Email Format
    Given path '/register'
    And header Accept = 'application/json'
    And header Content-Type = 'application/json'
    And request
      """
      {
        "firstName": "John",
        "lastName": "Doe",
        "email": "invalid-email",
        "password": "SecurePass123!",
        "confirmPassword": "SecurePass123!"
      }
      """
    When method POST
    Then status 400

  Scenario: User Registration - Dynamic Data with Variables
    * def randomEmail = 'user' + karate.env + java.lang.System.currentTimeMillis() + '@example.com'
    * def userData =
      """
      {
        "firstName": "Jane",
        "lastName": "Smith",
        "email": "#(randomEmail)",
        "password": "MySecurePass456!",
        "confirmPassword": "MySecurePass456!"
      }
      """

    Given path '/register'
    And header Accept = 'application/json'
    And header Content-Type = 'application/json'
    And request userData
    When method POST
    Then status 201
