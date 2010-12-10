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
        And I am on the services index page
        When I follow "New Service"
        Then I should see "Back"
        And I fill in "service[title]" with "cubicleapps.com - main"
        And I fill in "service[description]" with "Main application site"
        And I press "Create Service"
        Then I should see "The service was created successfully."
        And I should see "cubicleapps.com - main"
        And I should see "Main application site"

    Scenario: Display errors for invalid data in new form
        Given an authenticated admin
        And I am on the services index page
        When I follow "New Service"
        And I fill in "service[title]" with ""
        And I fill in "service[description]" with "Main application site"
        And I press "Create Service"
        Then I should see "New Service" 
        And I should see "1 error prohibited this service from being saved:"
        And I should see "Title can't be blank"

    Scenario: Edit a service
        Given an authenticated admin
        And a service with title "cubicleapps.com - main" and description "Main application site"
        And I am on the services index page
        When I follow "Edit cubicleapps.com - main"
        Then I should see "Back"
        And I fill in "service[title]" with "cubicleapps.com"
        And I fill in "service[description]" with "Main web service"
        And I press "Update Service"
        Then I should see "The service was updated successfully."
        And I should see "cubicleapps.com"
        And I should see "Main web service"
