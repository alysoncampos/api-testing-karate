Feature: Articles

    Background: Define URL
        Given url apiUrl
        #* def tokenResponse = callonce read('classpath:helpers/CreateToken.feature')
        #* def token = tokenResponse.authToken
    
    @ignore
    Scenario: Create a new article
        # Given header Authorization = 'Token ' + token
        Given path 'articles'
        And request {"article": {"title": "Bla bla Aly", "description": "test test", "body": "body", "tagList": []}}
        When method Post
        Then status 201
        And match response.article.title == 'Bla bla Aly'
    
    Scenario: Create and delete article
        # Given header Authorization = 'Token ' + token
        Given path 'articles'
        And request {"article": {"title": "Bla bla bla", "description": "test test", "body": "body", "tagList": []}}
        When method Post
        Then status 201
        * def articleId = response.article.slug

        # Given header Authorization = 'Token ' + token
        Given path 'articles'
        And params { limit:10, offset:0 }
        When method Get
        Then status 200
        And match response.articles[0].title == "Bla bla bla"

        # Given header Authorization = 'Token ' + token
        Given path 'articles',articleId
        When method Delete
        Then status 204

        # Given header Authorization = 'Token ' + token
        Given path 'articles'
        And params { limit:10, offset:0 }
        When method Get
        Then status 200
        And match response.articles[0].title != "Bla bla bla"
