Feature: Manage services
    In order to manage services
    As an authenticated admin
    I want to view, create, edit or delete services

    Scenario: List services and enable new, edit and destroy links
        Given an authenticated admin
        And a service with title "cubicleapps.com - main" and description "Main application site"
        When I follow "Services" within ".admin_link_bar"
        Then I should see "cubicleapps.com - main"
        And I should see "Edit"
        And I should see "Destroy"
        And I should see "Main application site"
        And I should see "New Service"

    Scenario: Create a service
        Given an authenticated admin
        And I go to the services index page
        When I follow "New Service"
        And I fill in "title" with "cubicleapps.com - main"
        And I fill in "description" with "Main application site"
        And I press "Create"
        Then I should see "Service was successfully created."
