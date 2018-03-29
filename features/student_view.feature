# features/student_view.feature
Feature: Student View
  As a student
  So that I can submit the force request
  I want to submit requests online

Background: students have been added to database 

Given the following students exist:
  | name           | uin        | password   | email              | major               |classification |
  | Andrew Bregger | 123123123  | 654321     | adb3649@tamu.edu   | computer science    |G              |
  | Adam will      | 789789789  | 456789     | Will@tamu.edu      | computer science    |G              |
  
  
  
Scenario: Add new requests
When I am on the Login Page
And I fill in correct login info
And I click login
And I should be on Student Dashboard Page and click profile
Then I should see my personal information
And I click OK
Then I should go back to dashboard
When I click on New Force Request, I should see my profile auto-filled, and fill in the form, and then click Save Request 
Then I should see my info
When I click on Withdraw
Then I should not see that request on Student Dashboard Page


Scenario: Student change password
When I am on the Login Page
And I fill in correct login info
And I click login
And I click change password button
Then I should be on change password page and fill it up
And I click change password button
When I fill the old password wrongly
Then I stay on the page on recieve warining
When I fill the new password wrongly
Then I stay on the page on recieve another warining
When I withdraw this request
Then I will back to student dashboard

Scenario: Student Logout
When I am on the Login Page
And I fill in correct login info
And I click login
And I click logout button
Then I should be on root page

Scenario: Student Forget Password
When I am on the Login Page
And I click forget password
Then I should be on reset password page
When I input my uin and click reset
Then I should be on root page