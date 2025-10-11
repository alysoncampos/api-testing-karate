Feature: Token

    Scenario: Create Token
        Given url 'https://conduit-api.bondaracademy.com/api/'
        And path 'users/login'
        And request {"user": {"email": "#(userEmail)","password": "#(userPassword)"}}
        When method Post
        Then status 200
        * def authToken = response.user.token