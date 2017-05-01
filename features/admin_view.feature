Feature: admin SignUp and login
  As an administrator
  So that I have all the privilege
  I want to login to the force request system with password
  
Scenario: Admin Login
Given I am on the Login Page as admin
And I use admin account to login
Then I should be on Admin View page
And I should see all requests here


Scenario: Admin Actions
Given I am on the Login Page as admin
And I use admin account to login
Then I should be on Admin View page
And I should see all requests here
When I click More Actions
Then I should go to action page
When I add a new admin
And I fill the info of new admin
Then I should back to admin dashboard
When I click More Actions
Then I should go to action page
When I click add a new student
And I fill the info of new student
Then I should go to action page
When I click add a new force request to system
And I fill the info of new request
Then I should go to action page
