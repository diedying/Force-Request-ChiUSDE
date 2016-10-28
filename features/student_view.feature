# features/student_view.feature
Feature: Student View

Scenario: Show my current requests
Given I am on the Student Dashboard Page
When I click on Add New Request
Then I should see my requests
