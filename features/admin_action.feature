Feature: admin process force request
  As an administrator
  So I can see all the force request
  I want to approve/reject force request

Scenario: Admin download
Given I am on the Login Page as admin
And I use admin account to login
Then I should be on Admin View page
And I should see all requests here
And I click Download button
Then I should get a download with the All_force_requests.csv