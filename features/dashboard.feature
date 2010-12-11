Feature: Dashboard
    In order to get information about tracked services
    As a visitor
    I want to see the list of services and their statuses, current and recent resolved issues

    Scenario: Recommend sign-up if no admin records
        Given no admins
        When I go to the dashboard page
        Then I should see "You should sign up for an admim account:"
        And I should see "sign up form" within "a"

    Scenario: Hide sign up form link when there are admin records
        Given an authenticated admin
        When I go to the dashboard page
        Then I should not see "You should sign up for an admim account:"
        And I should not see "sign up form" within "a"

    Scenario: List services status when no pending issues
        Given a service with title "cubicleapps.com - main" and description "Main application site"
        And no pending issues
        When I go to the dashboard page
        Then I should see "cubicleapps.com - main"
        And I should see "Main application site" 
        And I should see "(UP)"

    Scenario: List services status when current issues
        Given a service with title "cubicleapps.com - main" and description "Main application site"
        And a current issue "Hardware Failure" with severity status "4" for "cubicleapps.com - main"
        When I go to the dashboard page
        Then I should see "cubicleapps.com - main"
        And I should see "Main application site" 
        And I should see "(DOWN - 1 issue)"

    Scenario Outline: List services status (scenario outline version)
        Given a number of "<pending issues>" pending issues
        When I go to the dashboard page
        And I should see "<status>"

        Examples:
            | pending issues | status            |
            | 0              | (UP)              |
            | 1              | (DOWN - 1 issue)  |
            | 2              | (DOWN - 2 issues) |
            | 5              | (DOWN - 5 issues) |
