Feature: students SignUp
  As a student
  So that my information is protected
  I want to login to the force request system with password
  
Background: students have been added to database 

Given the following students exist:
  | name           | uin        | password   | email              |
  | Andrew Bregger | 123123123  | 654321     | adb3649@tamu.edu   |  
  | Adam will      | 789789789  | 456789     | Will@tamu.edu      |  

Scenario: Student SignUp 
When I am a student want to sign up for an account
Then I click on Sign Up
Then I will be on the Sign Up page
When I fill in the form incorrectly
And I click SignUp
Then I should stay on the same page
And recieve a warning massage
When I fill in with exsiting account information
And I click SignUp
Then I recieve another warning massage
Then I click on Sign Up
Then I will be on the Sign Up page
When I fill in the form correctly 
And I click SignUp
Then I should see my account create successfully




