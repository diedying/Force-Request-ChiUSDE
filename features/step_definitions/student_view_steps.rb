# features/step_definitions/contact_form_steps.rb
Given(/^I am a student have not registered on the Login Page$/) do
  visit('/')
  # fill_in('Enter your Name', :with => "1234312")
  # click_button('Sign Up')
  # majors = [{:major_id => 'CPSC'}, {:major_id => 'CECN'}, {:major_id => 'CEEN'}, {:major_id => 'ELEN'}, {:major_id => 'APMS'},
  #           {:major_id => 'CPSL'}, {:major_id => 'CECL'}, {:major_id => 'CEEL'}, {:major_id => 'Others'}]
  # existingMajors = Major.all
  # if existingMajors.blank?
  #   majors.each do |record|
  #     Major.create!(record)
  #   end
  # end
  
  page.has_content?("Login Page")
end

When(/^I click on Sign Up$/) do
  click_button('Sign Up')

end

Then(/^I will be on the Sign Up page$/) do
  page.has_content?("Enter your name")
  page.has_content?("Enter your UIN")
  page.has_content?("ReEnter your name")
  page.has_content?("Enter your email")
  page.has_content?("Enter your password")
  page.has_content?("ReEnter your password")  
end

When(/^I fill in the form wongly, and then click SignUp$/) do 
  @user_info = {:name => "mian qin", :email => "celery1124@tamu.edu", :password => "321", :UIN => "123123123"}
  fill_in('Enter your name', :with => @user_info[:name])
  fill_in('ReEnter your UIN', :with => "000000000")
  fill_in('Enter your UIN', :with => @user_info[:UIN])
  fill_in('Enter your email', :with => @user_info[:email])
  fill_in('Enter your password', :with => @user_info[:password])
  fill_in('ReEnter your password', :with => @user_info[:password])
  click_button('Signup')
end

Then(/^I should stay on the same page and recieve a warning massage$/) do
  #page.has_content?(/The twice entered UIN and password must be same!$/)
  if page.respond_to? :should
    page.should have_content("The twice entered UIN and password must be same!")
  else
    assert page.has_content?("The twice entered UIN and password must be same!")
  end
end

When(/^I fill in the form correctly, and then click SignUp$/) do 
  @user_info = {:name => "mian qin", :email => "celery1124@tamu.edu", :password => "321", :UIN => 123456789}
  fill_in('Enter your name', :with => @user_info[:name])
  fill_in('ReEnter your UIN', :with => @user_info[:UIN])
  fill_in('Enter your UIN', :with => @user_info[:UIN])
  fill_in('Enter your email', :with => @user_info[:email])
  fill_in('Enter your password', :with => @user_info[:password])
  fill_in('ReEnter your password', :with => @user_info[:password])
  click_button('Signup')
end

Then(/^I should see my account create successfully$/) do
  page.has_content?(/\w+signed up successfully!$/)
  page.has_content?("Login Page")
end

#...........2nd Senario........#

Given /the following students exist/ do |students|
  students.hashes.each do |student|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    # {"title"=>"Aladdin", "rating"=>"G", "release_date"=>"25-Nov-1992"}
    Student.create!(:name => 'Mian Qin', :uin => '123123123', :email => 'celery1124@tamu.edu', :password => '321',
                    :major => ' ', :classification => ' ')
  end
  #flunk "Unimplemented"
end

When(/^I am on the Login Page again$/) do
  visit('/')
  page.has_content?("Login Page")
end

And(/^I fill in the form with correct info, and then click login/) do
  @user_info = {:UIN => "123123123",  :password => "321"}
  fill_in('Enter your uin', :with => @user_info[:UIN])
  fill_in('Enter your password', :with => @user_info[:password])
  
  click_button('Login')
end

And(/^I should be on Student Dashboard Page and click profile$/) do
  # page.has_content?("Howdy! Welcome back Mian Qin")
  # click_button('Your Profile')
  if page.respond_to? :should
    page.should have_content("Howdy! Welcome back Mian Qin")
  else
    assert page.has_content?("Howdy! Welcome back Mian Qin")
  end
end

Then(/^I should see my personal information$/) do
  page.has_content?("Full Name")
  page.has_content?("Major")
  page.has_content?("Classification")
  page.has_content?("Email")
end

And (/^I click OK$/) do
  click_button('OK')
end

Then (/^I should go back to dashboard$/) do
  page.has_content?("New Force Request")
  page.has_content?("Your Profile")
  page.has_content?("Change Your Password")
end

When(/^I click on New Force Request, I should see my profile auto-filled, and fill in the form, and then click Save Request$/) do
  click_link('New Force Request')
  @student_request = {:minor=>"None", :phone=>"312321312", :expected_graduation=>"2018", :request_semester=>"Fall", :course_id=>"629", :Section_id => "600"}
  page.has_content?("123123123")
  page.has_content?("G*")
  # fill_in('UIN', :with => @student_request[:uin])
  # fill_in('Full Name*', :with => @student_request[:full_name])
  # select('CPSC', :from => 'Major*')
  # select('G7', :from => 'Classification')
  fill_in('Minor', :with => @student_request[:minor])
  # fill_in('Email*', :with => @student_request[:email])
  fill_in('Phone*', :with => @student_request[:phone])
  fill_in('Course Id*', :with => @student_request[:uin]) 
  click_button('Save Request')
end


Then(/^I should see my info$/) do
  page.has_content?("Students Dashboard Page")
  page.has_content?("629")
  page.has_content?("600")
end

When(/^I click on Withdraw$/) do
  click_button('Withdraw')
end

Then(/^I should not see that request on Student Dashboard Page$/) do
  page.has_content?("Student Request was successfully deleted")
end