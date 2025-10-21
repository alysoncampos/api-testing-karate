Feature: Articles

    Background: Define URL
        * url apiUrl
        * def articleRequestBody = read('classpath:conduitApp/json/newArticleRequest.json')
        * def dataGenerator = Java.type('helpers.DataGenerator')
        * set articleRequestBody.article.title = dataGenerator.getRandomArticle().title
        * set articleRequestBody.article.description = dataGenerator.getRandomArticle().description
        * set articleRequestBody.article.body = dataGenerator.getRandomArticle().body
        #* def tokenResponse = callonce read('classpath:helpers/CreateToken.feature')
        #* def token = tokenResponse.authToken

    Scenario: Create a new article
        # Given header Authorization = 'Token ' + token
        Given path 'articles'
        And request articleRequestBody
        When method Post
        Then status 201
        And match response.article.title == articleRequestBody.article.title

    @debug
    Scenario: Create and delete article
        # Given header Authorization = 'Token ' + token
        Given path 'articles'
        And request articleRequestBody
        When method Post
        Then status 201
        * def articleId = response.article.slug

        # Given header Authorization = 'Token ' + token
        Given path 'articles'
        And params { limit:10, offset:0 }
        When method Get
        Then status 200
        And match response.articles[0].title == articleRequestBody.article.title

        # Given header Authorization = 'Token ' + token
        Given path 'articles',articleId
        When method Delete
        Then status 204

        # Given header Authorization = 'Token ' + token
        Given path 'articles'
        And params { limit:10, offset:0 }
        When method Get
        Then status 200
        And match response.articles[0].title != articleRequestBody.article.title
