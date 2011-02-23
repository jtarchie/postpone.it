Feature: When a user associates social network accounts with their postpone.it account
  Background:
    Given I am a new, authenticated user
    Then I go to the accounts page

  Scenario: User can authorize Facebook
    When I follow "Facebook"
    And redirect back to the Facebook provider
    Then I should have been authorized with "Facebook"
    And I should see "Facebook (1)"