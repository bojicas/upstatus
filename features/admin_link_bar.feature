Feature: Admin link bar
    In order to quickly navigate between various views
    As an authenticated admin
    I should have a link (navigation) bar

    Background:
        Given an authenticated admin

    Scenario: Display link bar
        Then I should see "Dashboard"
        And I should see "Services"
        And I should see "Issues"
        And I should see "Sign out"

    Scenario Outline: Ensure links are working
        When I follow "<link>" within ".admin_link_bar"
        Then I should see "<page title>"

        Examples:
            | link      | page title               |
            | Dashboard | UP Status Dashboard      |
            | Services  | Services List            |
            | Issues    | Issues List              |
            | Sign out  | Signed out successfully. |
