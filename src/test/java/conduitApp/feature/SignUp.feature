@debug
Feature: Sign Up new user

    Background: Preconditions
        * def dataGenerator = Java.type('helpers.DataGenerator')
        * def randomEmail = dataGenerator.getRandomEmail()
        * def randomUsername = dataGenerator.getRandomUsername()
        * url apiUrl

    Scenario: New user Sign Up
        Given path 'users'
        And request 
        """
        {
            "user": {
                "email": #(randomEmail),
                "password": "123karate123",
                "username": #(randomUsername)
            }
        }
        """
        When method Post
        Then status 201
        And match response ==
        """
        {
          "user": {
            "id": '#number',
            "email": #(randomEmail),
            "username": #(randomUsername),
            "bio": null,
            "image": '#string',
            "token": '#string'
          }
        }
        """

  Scenario Outline: Validate Sign Up error messages
      Given path 'users'
      And request
        """
          {
            "user": {
              "email": "<email>",
              "password": "<password>",
              "username": "<username>"
            }
          }
        """
      When method Post
      Then status 422
      And match response == <errorResponse>

      Examples:
          | email                 | password  | username              | errorResponse                                                      |
          | #(randomEmail)        | Karate123 | KarateUserAly2        | {"errors":{"username":["has already been taken"]}}                 |
          | karate.aly12@test.com | Karate123 | #(randomUsername)     | {"errors":{"email":["has already been taken"]}}                    |
          | #(randomEmail)        | Karate123 | al                    | {"errors":{"username":["is too short (minimum is 3 characters)"]}} |
          | #(randomEmail)        | Karate123 | KarateUserAly23333333 | {"errors":{"username":["is too long (maximum is 20 characters)"]}} |