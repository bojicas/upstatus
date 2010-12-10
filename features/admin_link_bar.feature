Feature: Admnin link bar
    In order to quickly navigate between various views
    As an authenticated admin
    I should have a link (navigation) bar

    Scenario: Display link bar
        Given an authenticated admin
        Then I should see "Sign out" within "a"
