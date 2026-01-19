Feature: API Testing
  Scenario: Get list of all dogs
  Given url 'https://dog.ceo/api/breeds/list/all'
  When method GET
  Then status 200