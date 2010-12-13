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
        Then I should see "cubicleapps.com - main" within ".green_status"
        And I should see "All Systems Go"
        And I should see "No known issues at this time."
        And I should see "Main application site" 
        And I follow "History - Issues List"
        Then I should see "Issues List"

    Scenario: List services status when current issues
        Given a service with title "cubicleapps.com - main" and description "Main application site"
        And a current issue "Hardware Failure" with severity status "4" for "cubicleapps.com - main"
        And the above issue has description "Migrating to the cloud"
        And the above issue has been reported on "2010-12-11 14:03:00 UTC"
        And the above issue has an estimate of "2 hours"  
        When I go to the dashboard page
        Then I should see "cubicleapps.com - main" within ".red_status"
        And I should see "Main application site" 
        And I should see "Hardware Failure"
        And I should see "Severity: 4"
        And I should see "2010-12-11 14:03:00 UTC" 
        And I should see "2 hours"
        And I should see "Migrating to the cloud" 
        And I should not see "Edit"
        And I follow "History - Issues List"
        Then I should see "Issues List"

    Scenario Outline: List services status (scenario outline version)
        Given a number of "<pending issues>" pending issues
        When I go to the dashboard page
        Then I should see "cubicleapps.com - main" within "<status>"
        And I follow "History - Issues List"
        Then I should see "Issues List"

        Examples:
            | pending issues | status        |
            | 0              | .green_status |
            | 1              | .red_status   |
            | 2              | .red_status   |
            | 5              | .red_status   |

    Scenario: No edit links if no current issue
        Given an authenticated admin
        And no pending issues
        When I go to the dashboard page
        Then I should not see "Edit"

    Scenario: Show edit links if current issues
        Given an authenticated admin
        And a service with title "cubicleapps.com - main" and description "Main application site"
        And a current issue "Hardware Failure" with severity status "4" for "cubicleapps.com - main"
        When I go to the dashboard page
        Then I should see "Edit"
        And I follow "Edit"
        Then I should see "Edit Issue"
