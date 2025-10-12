@debug
Feature: Tests for the home page

    Background: Define URL
        Given url 'https://conduit-api.bondaracademy.com/api/' 
    
    
    Scenario: Get all tags
        Given path 'tags'
        When method Get
        Then status 200
        And match response.tags contains ['Bondar Academy', 'Git']
        And match response.tags !contains 'Truck'
        And match response.tags contains any ['Test', 'Alyson', 'Karate']
        And match response.tags == '#array'
        And match each response.tags == '#string'
    
    
    Scenario: Get 10 articles from the page
        Given params { limit:10, offset:0 }
        Given path 'articles'
        When method Get
        Then status 200
        And match response.articles == '#[10]'
        And match response.articlesCount == 11
        And match response == { 'articles': '#array', 'articlesCount': 11 }
        And match response.articles[0].createdAt contains '2025'
        And match response.articles[*].favoritesCount contains 0
        And match response..bio contains null
        And match each response..following == false