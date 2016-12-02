# features/step_definitions/contact_form_steps.rb
Given(/^I am on the Student Dashboard Page$/) do
  visit('/')
  fill_in('Enter your UIN', :with => "1234312")
  click_button('Login')
end

When(/^I click on New Force Request/) do
  click_link('New Force Request')
  @student_request = {:uin => "1234312", :full_name =>"Dummy Guy", :major=>"Computer Science", :classification=>"G8", 
  :minor=>"None", :email=>"dummy@dummy.com", :phone=>"312321312", :expected_graduation=>"2018", :request_semester=>"Fall", :course_id=>"12"}
  # fill_in('UIN', :with => @student_request[:uin])
  fill_in('Full Name*', :with => @student_request[:full_name])
  select('CPSC', :from => 'Major*')
  select('G7', :from => 'Classification')
  fill_in('Minor', :with => @student_request[:minor])
  fill_in('Email*', :with => @student_request[:email])
  fill_in('Phone*', :with => @student_request[:phone])
  fill_in('Course Id*', :with => @student_request[:uin]) 
  click_button('Save Request')
end

Then(/^I should see my request on Student Dashboard Page$/) do
  page.has_content?("Students Dashboard Page") and page.has_content?("Dummy")
end

When(/^I click on Withdraw$/) do
  click_link('New Force Request')
  @student_request = {:uin => "1234312", :full_name =>"Dummy Guy", :major=>"CPSC", :classification=>"G8", 
  :minor=>"MECH", :email=>"dummy@dummy.com", :phone=>"4693889213", :expected_graduation=>"2018 Fall", :request_semester=>"2017 Fall", :course_id=>"606", :section_id=>"600"}
  fill_in('Full Name*', :with => @student_request[:full_name])
  select('CPSC', :from => 'Major*')
  select('G7', :from => 'Classification')
  fill_in('Minor', :with => @student_request[:minor])
  fill_in('Email*', :with => @student_request[:email])
  fill_in('Phone*', :with => @student_request[:phone])
  select(@student_request[:expected_graduation], :from => 'Expected Graduation*')
  select(@student_request[:request_semester], :from => 'Request Semester*')
  fill_in('Course Id*', :with => @student_request[:course_id]) 
  fill_in('Section Id*', :with => @student_request[:section_id])  
  click_button('Save Request')
  
  click_button('Withdraw')
end

Then(/^I should not see that request on Student Dashboard Page$/) do
  page.has_content?("Student Request was successfully deleted")
end