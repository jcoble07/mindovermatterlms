@mod @mod_scorm
Feature: Scorm with no calendar capabilites
  In order to allow work effectively
  As a teacher
  I need to be able to create SCORM activities even when I cannot edit calendar events

  Background:
    Given the following "courses" exist:
      | fullname | shortname | category | groupmode |
      | Course 1 | C1 | 0 | 1 |
    And the following "users" exist:
      | username | firstname | lastname | email |
      | teacher1 | Teacher | 1 | teacher1@example.com |
    And the following "course enrolments" exist:
      | user | course | role |
      | teacher1 | C1 | editingteacher |
    And I log in as "admin"
    And I am on the "Course 1" "permissions" page
    And I override the system permissions of "Teacher" role with:
      | capability | permission |
      | moodle/calendar:manageentries | Prohibit |
    And I log out

  @javascript @_file_upload @_switch_iframe
  Scenario: Editing a scorm activity without calendar permission
    Given I log in as "admin"
    And I am on "Course 1" course homepage with editing mode on
    When I add a "SCORM package" to section "1"
    And I set the following fields to these values:
      | Name | Test scorm name |
      | Description | Test scorm description |
      | id_timeopen_enabled | 1 |
      | id_timeopen_day | 1 |
      | id_timeopen_month | 1 |
      | id_timeopen_year | 2017 |
      | id_timeclose_enabled | 1 |
      | id_timeclose_day | 1 |
      | id_timeclose_month | 2 |
      | id_timeclose_year | 2017 |
    And I upload "mod/scorm/tests/packages/singlesco_scorm12.zip" file to "Package file" filemanager
    And I click on "Save and display" "button"
    And I log out
    When I am on the "Test scorm name" "scorm activity editing" page logged in as teacher1
    And I set the following fields to these values:
      | id_timeopen_year | 2018 |
      | id_timeclose_year | 2018 |
    And I press "Save and return to course"
    Then I should see "Test scorm name"
