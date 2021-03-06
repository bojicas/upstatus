Feature: Manage issues
    In order to manage issues
    As an authenticated admin
    I want to view, create, edit or delete issues

    Scenario Outline: List issues public view
        Given a service with title "cubicleapps.com - main" and description "Main application site"
        And a current issue "Hardware Failure" with severity status "<severity>" for "cubicleapps.com - main"
        And the above issue has description "Migrating to the cloud"
        And the above issue has been reported on "2010-12-11 14:03:00 UTC"
        And the above issue has an estimate of "2 hours"  
        And the above issue has resolved status "<resolved>" and time up "<time up>"
        When I go to the issues index page
        Then I should see "cubicleapps.com - main" within ".severity_<severity>"
        And I should see "Hardware Failure"
        And I should see "<status>" within "<color>"
        And I should see "Severity: <severity>"
        And I should see "2010-12-11 14:03:00 UTC"
        And I should see "2 hours"
        And I should see "<time up>"
        And I should see "Migrating to the cloud"
        And I should not see "New Issue"
        And I should not see the link "Edit"
        And I should not see the link "Destroy"
        And I should not see the link "Destroy"
        And I follow "Back to Dashboard"
        Then I should see "UP Status Dashboard"

        Examples:
            | resolved | time up                 | severity | status   | color  |
            | true     | 2010-12-11 14:35:00 UTC | 1        | Resolved | .green |
            | false    |                         | 2        | Pending  | .red   |
            | true     | 2010-12-11 14:35:00 UTC | 3        | Resolved | .green |
            | false    |                         | 4        | Pending  | .red   |
            | true     | 2010-12-11 14:35:00 UTC | 5        | Resolved | .green |

    Scenario: List issues (resolved issues only, just for demo purposes, see outline above to be removed)
        Given a service with title "cubicleapps.com - main" and description "Main application site"
        And a current issue "Hardware Failure" with severity status "4" for "cubicleapps.com - main"
        And the above issue has description "Migrating to the cloud"
        And the above issue has been reported on "2010-12-11 14:03:00 UTC"
        And the above issue has an estimate of "2 hours"  
        And the above issue has resolved status "true" and time up "2010-12-11 14:03:00 UTC"
        When I go to the issues index page
        Then I should see "cubicleapps.com - main"
        And I should see "Hardware Failure"
        And I should see "Resolved" within ".green"
        And I should see "Severity: 4"
        And I should see "2010-12-11 14:03:00 UTC"
        And I should see "2 hours"
        And I should see "2010-12-11 14:03:00 UTC"
        And I should see "Migrating to the cloud"
        And I should not see "New Issue"
        And I should not see the link "Edit"
        And I should not see the link "Destroy"
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
        Then I should see "New Issue"
        And I should see "Back"
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
        And I should see "Issues List"
        And I should see "Hardware Faillure"

     Scenario: Display errors for invalid data in new form
        Given an authenticated admin
        And a service with title "cubicleapps.com - main" and description "Main application site"
        And I am on the issues index page
        When I follow "New Issue"
        And I fill in "issue_title" with ""
        And I press "Create Issue"
        Then I should see "New Issue" 
        And I should see "1 error prohibited this item from being saved:"
        And I should see "Title can't be blank"  


    Scenario: Edit an issue
        Given an authenticated admin
        And a service with title "cubicleapps.com - main" and description "Main application site"
        And a current issue "Hardware Failure" with severity status "4" for "cubicleapps.com - main"
        And I am on the issues index page
        When I follow "Edit"
        Then I should see "Edit Issue"
        And I should see "Back"
        And I fill in the following:
            | issue_title        | Hardware Failure                |
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
        And I press "Update Issue"
        Then I should see "The issue was updated successfully."
        And I should see "Issues List"
        And I should see "Hardware Failure"

    Scenario Outline: Destroy an issue
        Given an authenticated admin
        And a service with title "cubicleapps.com - main" and description "Main application site"
        And a current issue "Hardware Failure" with severity status "4" for "cubicleapps.com - main"
        And I am on the <page> page
        When I follow "Destroy"
        Then I should see "The issue was destroyed successfully."
        And I should not see "Hardware Failure"

        Examples:
            | page         |
            | dashboard    |
            | issues index |
