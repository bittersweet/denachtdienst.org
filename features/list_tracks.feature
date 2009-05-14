Feature: List Tracks
  In order to see all the tracks
  As a user
  I want to list tracks
  
  Scenario: Tracks upload and list
    Given I am logged in as an Admin
    Given I have tracks titled Test track 1, Test track 2
    When I go to the list of tracks
    Then I should see "Test track 1"
    And I should see "Test track 2" 
    
  Scenario: Check profile
    Given I am logged in as an Admin
    When I go to the profile page
    Then I should see "edit"
    And I should see "change password" 
    And I should see my account details
    
