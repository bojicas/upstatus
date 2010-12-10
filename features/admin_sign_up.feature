Feature: Admin sign up
    In order to manage services and their issuer
    As future admin
    I want to sign up for an admin account

    Scenario:
        Given no admins
        When I go to the sign up page
        And I fill in "admin_email" with "admin@cubicleapps.com"
        And I fill in "admin_password" with "secretpass"
        And I fill in "admin_password_confirmation" with "secretpass"
        And I press "Sign up"
        Then I should see "You have signed up successfully."
