Feature: When a user associates social network accounts with their postpone.it account
  Background:
    Given I am a new, authenticated user
    Then I go to the accounts page
    And we stub out Omniauth

  Scenario: User can authorize Facebook
    Then I should see "Facebook (0)"
    When I follow "Facebook"
    And redirect back to the Facebook provider
    Then I should have been authorized with "Facebook"
    And I should see "Facebook (1)"
    And I should see "Successfully authorized with Facebook"

  Scenario: User can authorize Twitter
    Then I should see "Twitter (0)"
    When I follow "Twitter"
    And redirect back to the Twitter provider
    Then I should have been authorized with "Twitter"
    And I should see "Twitter (1)"
    And I should see "Successfully authorized with Twitter"