Feature: User Registration Tests

  Background:
    * url 'https://www.ndosiautomation.co.za/API'
    * header Accept = 'application/json'
    * header Content-Type = 'application/json'
    * def groupId = 'ece0c2ce-f91b-11f0-9e70-5000e6331276'

  Scenario Outline: User Registration - <case>

    * def email =
    """
    <useRandomEmail> == true
      ? 'user' + java.lang.System.currentTimeMillis() + '@example.com'
      : '<email>'
    """

    Given path '/register'
    And request
  """
  {
    "firstName": "<firstName>",
    "lastName": "<lastName>",
    "email": "#(email)",
    "groupId": "<groupId>",
    "password": "<password>",
    "confirmPassword": "<confirmPassword>"
  }
  """
    When method POST
    Then status <status>
    And match response.success == ( <status> == 201 )

    Examples:
      | case                 | firstName | lastName | email              | useRandomEmail | groupId        | password         | confirmPassword     | status |
      | Valid registration   | Barre     | Gazii    | ignore             | true           | #(groupId)     | Pass1234         | Pass1234            | 201    |
      | Missing fields       | John      |          | john@example.com   | false          |                |                  |                     | 400    |
      | Password mismatch    | John      | Doe      | john@example.com   | false          | #(groupId)     | SecurePass123!   | DifferentPass123!   | 400    |
      | Invalid email format | John      | Doe      | invalid-email      | false          | #(groupId)     | SecurePass123!   | SecurePass123!      | 400    |
