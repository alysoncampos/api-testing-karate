Feature: Sign Up new user

    Background: Preconditions
        * def dataGenerator = Java.type('helpers.DataGenerator')
        * url apiUrl

    @debug
    Scenario: New user Sign Up
        * def randomEmail = dataGenerator.getRandomEmail()
        * def randomUsername = dataGenerator.getRandomUsername()

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