Feature: Login helper

  Background:
    * url 'https://www.ndosiautomation.co.za/API'
    * header Accept = 'application/json'
    * header Content-Type = 'application/json'

  Scenario: Login and return token
    Given path '/login'
    And request
  """
  {
    "email": "admin@gmail.com",
    "password": "12345678"
  }
  """
    When method POST
    Then status 200
    And match response.success == true

    * def token = response.data.token
    * print 'Login token:', token
