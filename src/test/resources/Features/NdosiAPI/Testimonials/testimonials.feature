Feature: Testimonials API Tests

  Background:
    * url 'https://www.ndosiautomation.co.za/API'
    * header Accept = 'application/json'
    * header Content-Type = 'application/json'

    * def loginResult = call read('classpath:Features/NdosiAPI/Common/login.feature')
    * def token = loginResult.token
    * print 'Using token:', token
    * header Authorization = 'Bearer ' + token

  Scenario: Get testimonials with pagination
    Given path '/testimonials'
    And param page = 1
    And param limit = 10
    When method GET
    Then status 200

  Scenario: Create testimonial successfully
    Given path '/testimonials'
    And request
  """
  {
    "title": "Great Service!",
    "content": "Amazing experience from start to finish.",
    "rating": 5,
    "isPublic": true
  }
  """
    When method POST
    Then status 201
    And match response.success == true
    * def testimonialId = response.data.Id

  Scenario: Fetch my testimonials
    Given path '/my-testimonials'
    When method GET
    Then status 200
    And match response.success == true

  Scenario: Update a testimonial
    Given path '/testimonials'
    And request
  """
  {
    "title": "Temp",
    "content": "Will be updated",
    "rating": 3,
    "isPublic": true
  }
  """
    When method POST
    Then status 201
    * def testimonialId = response.data.Id

    Given header Authorization = 'Bearer ' + token
    And path '/testimonials', testimonialId
    And request
  """
  {
    "content": "Updated testimonial content",
    "rating": 4
  }
  """
    When method PUT
    Then status 200
    And match response.success == true

  Scenario: Delete a testimonial
    Given path '/testimonials'
    And request
  """
  {
    "title": "Delete Me",
    "content": "This will be deleted",
    "rating": 3,
    "isPublic": true
  }
  """
    When method POST
    Then status 201
    * def testimonialId = response.data.Id

    Given header Authorization = 'Bearer ' + token
    And path '/testimonials', testimonialId
    When method DELETE
    Then status 200
    And match response.success == true
