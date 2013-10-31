Feature: Install OsiriX

  In order to use OsiriX
  As a user
  I want to have it installed first... of course

  @announce
  Scenario: Happy Path
    Given chef is setup
    And OsiriX was already downloaded
    When I run chef
    Then OsiriX should be installed
