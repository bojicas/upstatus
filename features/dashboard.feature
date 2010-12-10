Feature: Dashboard
    In order to get information about tracked services
    As a visitor
    I want to see the list of services and their statuses, current and recent resolved issues

    Scenario: Recommend sign-up if no admin records
        Given no admins
        When I go to the dashboard page
        Then I should see "You should sign up for an admim account:"
        And I should see "sign up form" within "a"

    Scenario: List services
        Given a service with title "cubicleapps.com - main" and description "Main application site"
        When I go to the dashboard page
        Then I should see "cubicleapps.com - main"
        And I should see "Main application site" 
