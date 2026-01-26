Feature: ReqRes API Tests

  Background:
    * url 'https://reqres.in'

Feature: ReqRes API Tests

  Background:
    * url 'https://reqres.in'

  Scenario: Get list of users with API key
    Given path '/api/users'
    And param page = 2
    And header x-api-key = 'reqres-free-v1'
    And header Accept = 'application/json'
    When method GET
    Then status 200
    And match response.data[0].id == 7
    And match response.data[*].first_name contains 'Tobias'
    And match response.data[*].last_name contains 'Funke'
    * print 'Response:', response



