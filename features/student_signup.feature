Feature: students SignUp
  As a student
  I want to sign up for a force request account
  So that I can submit my force request application
  
Background: students have been added to database 

Given the following students exist:
  | name           | uin        | password   | email              |
  | Andrew Bregger | 123123123  | 654321     | adb3649@tamu.edu   |  
  | Adam will      | 789789789  | 456789     | Will@tamu.edu      |  

Scenario: Student SignUp with incorrect information
Given I am a student want to sign up for an account
When I click on Sign Up
Then I will be on the Sign Up page
When I enter two different password or UIN information
And I click SignUp
Then I should stay on the same page
And I should recieve a mismatch warning massage
When I enter a email does not exsiting in TAMU system
And I click SignUp
Then I should stay on the same page
And I should recieve a no-record warning massage
When I use a UIN which already been used to sign up
And I click SignUp
Then I should return to root page
And I should recieve a account-exist warning massage


Scenario: Student SignUp with correct information
Given I am a student want to sign up for an account
When I click on Sign Up
Then I will be on the Sign Up page
When I enter correct information 
And I click SignUp
Then I should see my account create successfully