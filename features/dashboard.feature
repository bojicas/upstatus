Feature: Dashboard
    In order to get information about tracked services
    As a visitor
    I want to see the list of services and their statuses, current and recent resolved issues

    Scenario Outline: Dashboard view for all services up and running
        Given following services
            | title                  | description                    |
            | cubicleapps.com - main | Main application site          |
            | cubicleapps.net - docs | Documentation and support site |
        When I go to the dashboard page
        Then I should see "<service_title>"
        And I should see "<service_description>"
        And show me the page

        Examples:
            | service_title          | service_description            |
            | cubicleapps.com - main | Main application site          |
            | cubicleapps.net - docs | Documentation and support site |
