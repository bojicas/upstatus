Feature: Manage issues
    In order to manage issues
    As an authenticated admin
    I want to view, create, edit or delete issues

    Scenario: List issues (public view)
        Given a service with title "cubicleapps.com - main" and description "Main application site"
        And a current issue "Hardware Failure" with severity status "4" for "cubicleapps.com - main"
        When I go to the issues index page
        Then I should see "cubicleapps.com - main"
        And I should see "Hardware Failure"
        And I should see "Severity: 4"
        And I should see "Resolved: false"
        And I should not see "New Issue"
        And I follow "Back to Dashboard"
        Then I should see "UP Status Dashboard"

    Scenario: Ensure New Issues Link on admin
        Given an authenticated admin
        When I go to the issues index page
        And I follow "New Issue"
        Then I should see "New Issue"

    Scenario: Create an issue
        Given an authenticated admin
        And a service with title "cubicleapps.com - main" and description "Main application site"
        When I go to the issues index page
        And I follow "New Issue"
        Then I should see "Back"
        And I fill in the following:
            | issue_title        | Hardware Faillure               |
            | issue_description  | Moving the service to the cloud |
            | issue_estimate     | 2 hours                         |
        And select "cubicleapps.com - main" from "issue_service_id"
        And select "3" from "issue_severity"
        And select "2010" from "issue_time_down_1i"
        And select "December" from "issue_time_down_2i"
        And select "11" from "issue_time_down_3i"
        And select "13" from "issue_time_down_4i"
        And select "28" from "issue_time_down_5i"
        And check "issue_resolved"
        And select "2010" from "issue_time_up_1i"
        And select "December" from "issue_time_up_2i"
        And select "11" from "issue_time_up_3i"
        And select "15" from "issue_time_up_4i"
        And select "49" from "issue_time_up_5i"
        And I press "Create Issue"
        Then I should see "The issue was created successfully."
