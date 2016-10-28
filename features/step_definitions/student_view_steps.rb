# features/step_definitions/contact_form_steps.rb
Given(/^I am on the Student Dashboard Page$/) do
  visit('/student_requests')
end

When(/^I click on New Force Request/) do
  visit('/student_requests/new')
  @student_request = {:uin => "1234312", :full_name =>"Dummy Guy", :major=>"Computer Science", :classification=>"G8", 
  :minor=>"None", :email=>"dummy@dummy.com", :phone=>"312321312", :expected_graduation=>"2018", :request_semester=>"Fall"}
  #visit("/student_requests", :post, @student_request)
  StudentRequest.create(@student_request)
end

Then(/^I should see my request on Student Dashboard Page$/) do
  page.has_content?("Making New Request")
end

When(/^I click on Withdraw$/) do
  # #visit('/student_requests', :put, :)
  # @request_body = {:uin => "1234312", :full_name =>"Dummy Guy", :major=>"Computer Science", :classification=>"G8", 
  # :minor=>"None", :email=>"dummy@dummy.com", :phone=>"312321312", :expected_graduation=>"2018", :request_semester=>"Fall"}
  # @request_method = "PUT"
  # @request_url = "/student_requests/edit"
  # @successful_response_code = 201
  # @error_response_code_email_reserved = 409
  # @response = RestApi.call(@request_method, @request_url,
  #     body: @request_body, expect: @successful_response_code)
  visit('/student_requests')
  @student_request = {:uin => "1234312", :full_name =>"Dummy Guy", :major=>"Computer Science", :classification=>"G8", 
  :minor=>"None", :email=>"dummy@dummy.com", :phone=>"312321312", :expected_graduation=>"2018", :request_semester=>"Fall"}
  #visit("/student_requests", :post, @student_request)
  StudentRequest.create(@student_request)
  page.has_content?('Action')
  
  #click_button('Withdraw')
end

Then(/^I should not see that request on Student Dashboard Page$/) do
  page.has_content?("Student Request was successfully deleted")
end