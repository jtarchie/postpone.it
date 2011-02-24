Feature: When a user associates social network accounts with their postpone.it account
  Background:
    Given I am a new, authenticated user
    Then I go to the accounts page

  Scenario: User can authorize Facebook
    Then I should see "Facebook (0)"
    And we authorize with "Facebook"
    Then I should have been authorized with "Facebook"
    And I should see "Facebook (1)"
    And I should see "Successfully authorized with Facebook"

  Scenario: User can authorize Twitter
    Then I should see "Twitter (0)"
    And we authorize with "Twitter"
    Then I should have been authorized with "Twitter"
    And I should see "Twitter (1)"
    And I should see "Successfully authorized with Twitter"

  Scenario: User can authorize Vimeo
    Then I should see "Vimeo (0)"
    And we authorize with "Vimeo"
    Then I should have been authorized with "Vimeo"
    And I should see "Vimeo (1)"
    And I should see "Successfully authorized with Vimeo"

  Scenario: User can authorize Youtube
    Then I should see "YouTube (0)"
    And we authorize with "YouTube"
    Then I should have been authorized with "YouTube"
    And I should see "YouTube (1)"
    And I should see "Successfully authorized with YouTube"