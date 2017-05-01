# features/student_view.feature
Feature: Student View
  As a student
  So that I can submit the force request
  I want to submit requests online

Scenario: Add new requests
When I am on the Login Page again
And I fill in the form with correct info, and then click login
And I should be on Student Dashboard Page and click profile
Then I should see my personal information
And I click OK
Then I should go back to dashboard
When I click on New Force Request, I should see my profile auto-filled, and fill in the form, and then click Save Request 
Then I should see my info
When I click on Withdraw
Then I should not see that request on Student Dashboard Page


Scenario: Student change password
When I am on the Login Page again
And I fill in the form with correct info, and then click login
And I click change password button
Then I should be on change password page and fill it up

Scenario: Student Logout
When I am on the Login Page again
And I fill in the form with correct info, and then click login
And I click logout button
Then I should be on root page

Scenario: Student Forget Password
When I am on the Login Page again
And I click forget password
Then I should be on reset password page
When I input my uin and click reset
Then I should be on root page