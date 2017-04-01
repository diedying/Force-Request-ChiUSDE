# features/student_view.feature
Feature: Student requests

# Scenario: Add new requests
# Given I am on the Student Dashboard Page
# When I click on New Force Request, and fill in the form, and then click Save Request 
# Then I should see my request on Student Dashboard Page

# Scenario: Withdraw request
# Given I am on the Student Dashboard Page
# When I click on Withdraw
# Then I should not see that request on Student Dashboard Page

Scenario: Add user
Given I am on the Login Page
When I click on Sign Up
Then I am on the Signup Page
When I fill in the form, and then click Signup
Then I should see my infomation on Student Dashboard Page

Scenario: Add new requests
Given I am on the Login Page again
When I fill in the form with correct info, and then click login
Then I should see my request on Student Dashboard Page
When I click on New Force Request, and fill in the form, and then click Save Request 
Then I should see my info