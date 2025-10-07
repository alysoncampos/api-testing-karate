Feature: Articles

    Background: Define URL
        Given url 'https://conduit-api.bondaracademy.com/api/'
        And path 'users/login'
        And request {"user": {"email": "karate.aly@test.com","password": "karate123"}}
        When method Post
        Then status 200
        * def token = response.user.token
    
    @ignore
    Scenario: Create a new article
        Given header Authorization = 'Token ' + token
        And path 'articles'
        And request {"article": {"title": "Bla bla Aly", "description": "test test", "body": "body", "tagList": []}}
        When method Post
        Then status 201
        And match response.article.title == 'Bla bla Aly'
    
    @debug
    Scenario: Create and delete article
        Given header Authorization = 'Token ' + token
        And path 'articles'
        And request {"article": {"title": "Bla bla bla", "description": "test test", "body": "body", "tagList": []}}
        When method Post
        Then status 201
        * def articleId = response.article.slug

        Given header Authorization = 'Token ' + token
        And params { limit:10, offset:0 }
        And path 'articles'
        When method Get
        Then status 200
        And match response.articles[0].title == "Bla bla bla"

        Given header Authorization = 'Token ' + token
        And path 'articles',articleId
        When method Delete
        Then status 204

        Given header Authorization = 'Token ' + token
        And params { limit:10, offset:0 }
        And path 'articles'
        When method Get
        Then status 200
        And match response.articles[0].title != "Bla bla bla"
