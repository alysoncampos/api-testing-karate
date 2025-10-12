@ignore
Feature: Sign Up new user

    Background: Preconditions
        Given url apiUrl
    
    Scenario: New user Sign Up
        Given def userData =  {"email": "karate.aly234@test.com", "username": "UserAly234"}

        Given path 'users'
        And request 
        """
        {
            "user": {
                "email": #(userData.email),
                "password": "123karate123",
                "username": #(userData.username)
            }
        }
        """
        When method Post
        Then status 201