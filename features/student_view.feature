# features/student_view.feature
Feature: Student requests

Scenario: Add new requests
Given I am on the Student Dashboard Page
When I click on New Force Request, and fill in the form, and then click Save Request 
Then I should see my request on Student Dashboard Page

Scenario: Withdraw request
Given I am on the Student Dashboard Page
When I click on Withdraw
Then I should not see that request on Student Dashboard Page