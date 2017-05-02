Feature: students SignUp and login
  As a student
  So that my information is protected
  I want to login to the force request system with password
  
  
Scenario: Student SignUp 
Given I am a student have not registered on the Login Page
When I click on Sign Up
Then I will be on the Sign Up page
When I sign up wirh existed uin
Then I should recieve the warning massage
When I click on Sign Up
When I fill in the form wongly, and then click SignUp
Then I should stay on the same page and recieve a warning massage
When I fill in the form correctly, and then click SignUp
Then I should see my account create successfully


Given the following students exist:
  | name          |       uin    | password     |   email                |
  | Mo Li         |   126003824  |  123123      |   king_lm@tamu.edu     |
  | Mian Qin      |   123123123  |    321       |   celery1124@tamu.edu  |
  | Jiechen Zhong |   222111333  |    zxc       |   chen0209app@tamu.edu |


Scenario: Student Login
When I am on the Login Page again
And I fill in the form with correct info, and then click login
And I should be on Student Dashboard Page and click profile
Then I should see my personal information
And I click OK
Then I should go back to dashboard



