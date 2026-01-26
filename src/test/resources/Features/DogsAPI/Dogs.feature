Feature: API Testing
  Scenario: Get list of all dogs
    Given url 'https://dog.ceo/api/breeds/list/all'
    When method GET
    Then status 200
    And match response.status == 'success'
    And match response.message == '#object'
    And match response.message contains { retriever: '#array' }
    And print response