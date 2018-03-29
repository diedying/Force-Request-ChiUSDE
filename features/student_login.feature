Feature: students Login
  As a student
  So that my information is protected
  I want to login to the force request system with password
  
Background: students have been added to database 

Given the following students exist:
  | name           | uin        | password   | email              |
  | Andrew Bregger | 123123123  | 654321     | adb3649@tamu.edu   |  
  | Adam will      | 789789789  | 456789     | Will@tamu.edu      |  

Scenario: Student Login
When I am on the Login Page
And I fill in correct login info
And I click login
And I should be on Student Dashboard Page and click profile
Then I should see my personal information
And I click OK
Then I should go back to dashboard