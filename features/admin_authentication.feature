Feature: Admin authentication
    In order to manage services and their issues
    As an admin
    I want to sign in and sign out

    Scenario: Admin signs in
        Given an admin "admin@cubicleapps.com" with password "secretpass"
        When I go to the sign in page
        And I fill in "admin_email" with "admin@cubicleapps.com"
        And I fill in "admin_password" with "secretpass"
        And I press "Sign in"
        Then I should see "Signed in successfully."

    Scenario: Admin signs out
        Given an authenticated admin
        When I follow "Sign out" within ".admin_link_bar"
        Then I should see "Signed out successfully."
