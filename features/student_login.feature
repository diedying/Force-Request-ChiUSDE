Feature: students Login
  As a student
  So that my information is protected
  I want to login to the force request system with password
  
Background: activators have been added to database 

Given the following activators exist:
  | name           | uin        | password   | email              |
  | Andrew Bregger | 123123123  | 654321     | adb3649@tamu.edu   |  

Scenario: fail to login
When I am on the Login Page
When I login in with a account doesn't exsit
Then I should stay at the same page
And I should see a non-account exsits message
When I enter wrong login information
Then I should stay at the same page
And I should see a error message
When I login in with account has not been activate
Then I should stay at the same page
And I should see a not-activated message
 

