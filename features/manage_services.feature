Feature: Manage services
    In order to manage services
    As an authenticated admin
    I want to view, create, edit or delete services

    Scenario: List services and enable access to the edit files
        Given an authenticated admin
        And a service with title "cubicleapps.com - main" and description "Main application site"
        When I follow "Services" within ".admin_link_bar"
        Then I should see "cubicleapps.com - main" within "a"
        And show me the page
