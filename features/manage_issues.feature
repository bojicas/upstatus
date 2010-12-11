Feature: Manage issues
    In order to manage issues
    As an authenticated admin
    I want to view, create, edit or delete issues

    Scenario: List issues (public view)
        Given a service with title "cubicleapps.com - main" and description "Main application site"
        And a current issue "Hardware Failure" with severity status "4" for "cubicleapps.com - main"
        When I go to the issues page
        Then I should see "cubicleapps.com - main"
        And I should see "Hardware Failure"
        And I should see "Severity: 4"
        And I should see "Resolved: false"
        And I should not see "New Issue"
        And I follow "Back to Dashboard"
        Then I should see "UP Status Dashboard"

    Scenario: Ensure New Issues Link on admin
        Given an authenticated admin
        When I go to the issues page
        And I follow "New Issue"
        Then I should see "New Issue"
        And show me the page

