Feature: Ndosi API Registration Tests

  Background:
    * url 'https://www.ndosiautomation.co.za/API'
    * header Accept = 'application/json'
    * header Content-Type = 'application/json'

  Scenario: User Registration - Valid Data
    * def randomEmail = 'user' + karate.env + java.lang.System.currentTimeMillis() + '@example.com'
    Given path '/register'
    And header Accept = 'application/json'
    And header Content-Type = 'application/json'
    And request
      """
      {
        "firstName": "Barre",
        "lastName": "Gazii",
        "email": "#(randomEmail)",
        "groupId": "ece0c2ce-f91b-11f0-9e70-5000e6331276",
        "password": "Pass1234",
        "confirmPassword": "Pass1234"
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
        "groupId": "ece0c2ce-f91b-11f0-9e70-5000e6331276",
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
        "groupId": "ece0c2ce-f91b-11f0-9e70-5000e6331276",
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
        "groupId": "ece0c2ce-f91b-11f0-9e70-5000e6331276",
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

  Scenario: Successful login
    Given path '/login'
    And header Accept = 'application/json'
    And header Content-Type = 'application/json'
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
    * print 'TOKEN:', token


  Scenario: Get testimonials with pagination
    Given path '/testimonials'
    And param page = 1
    And param limit = 10
    And header Accept = 'application/json'
    When method GET
    Then status 200


  Scenario: Login and create testimonial successfully

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
    * print 'TOKEN:', token

    Given path '/testimonials'
    And header Authorization = 'Bearer ' + token
    And request
    """
    {
      "title": "Great Service!",
      "content": "I had a great experience from start to finish. The team was professional, responsive, and delivered exactly what was promised. I would definitely recommend their services to anyone looking for reliable and high-quality work.",
      "rating": 5,
      "isPublic": true
    }
    """
    When method POST
    Then status 201
    And match response.success == true

    * def testimonialId = response.data.Id
    * print 'Created Testimonial ID:', testimonialId

  Scenario: Fetch my testimonials
    Given path '/login'
    And header Accept = 'application/json'
    And header Content-Type = 'application/json'
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
    * print 'TOKEN:', token

    Given path '/my-testimonials'
    And header Accept = 'application/json'
    And header Authorization = 'Bearer ' + token
    When method GET
    Then status 200
    And match response.success == true

  Scenario: Update a testimonial
    Given path '/login'
    And header Accept = 'application/json'
    And header Content-Type = 'application/json'
    And request
    """
    {
      "email": "admin@gmail.com",
      "password": "12345678"
    }
    """
    When method POST
    Then status 200
    * def token = response.data.token
    * print 'TOKEN:', token


    * def testimonialId = "963b43dd-b58d-4438-b8ac-931cf1eb1d8b"
    * def updatedTestimonial =
    """
    {
      "content": "Updated testimonial content",
      "rating": 4
    }
    """
    Given path '/testimonials', testimonialId
    And header Accept = 'application/json'
    And header Content-Type = 'application/json'
    And header Authorization = 'Bearer ' + token
    And request updatedTestimonial
    When method PUT
    Then status 200
    And print response
    And match response.success == true


  Scenario: Login and delete a testimonial

    Given path '/login'
    And header Accept = 'application/json'
    And header Content-Type = 'application/json'
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
    * print 'TOKEN:', token


    Given path '/testimonials'
    And header Authorization = 'Bearer ' + token
    And header Content-Type = 'application/json'
    And request
    """
    {
      "title": "Temp Testimonial",
      "content": "This testimonial will be deleted.",
      "rating": 3,
      "isPublic": true
    }
    """
    When method POST
    Then status 201
    * def testimonialId = response.data.Id
    * print 'Created Testimonial ID:', testimonialId


    Given path '/testimonials', testimonialId
    And header Authorization = 'Bearer ' + token
    When method DELETE
    Then status 200
    And match response.success == true














