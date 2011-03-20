Feature: When a user is looking at their videos
  Background:
    Given I am a new, authenticated user
    And I have a video
    Then I go to the videos page

  Scenario: Deleting a video
    When I press "Delete"
    Then I should be on the videos page
    And I should see "Successfully deleted video."

  Scenario: Creating a video
    Given I should not see "New Video 123"
    When I follow "Add Video"
    Then I should be on the new video page
    When I fill in "video_title" with "New Video 123"
    And I fill in "video_url" with "http://url.com/video.mov"
    And I fill in "video_description" with "Description"
    And I press "Create Video"
    Then I should be on the videos page
    And I should see "New Video 123"

  Scenario: Editing a video
    Given I should not see "Edit Video 123"
    When I follow "Edit"
    When I fill in "video_title" with "Edit Video 123"
    And I fill in "video_url" with "http://url.com/video.mov"
    And I fill in "video_description" with "Description"
    And I press "Update Video"
    Then I should be on the videos page
    And I should see "Edit Video 123"
