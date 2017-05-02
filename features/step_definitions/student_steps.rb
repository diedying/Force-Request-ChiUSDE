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
  
  page.should have_content("Login Page")
end

When(/^I click on Sign Up$/) do
  click_link('Sign Up')

end

Then(/^I will be on the Sign Up page$/) do
  page.should have_content("Enter your full name")
  page.should have_content("Enter your UIN")
  page.should have_content("ReEnter your UIN")
  page.should have_content("Enter your email")
  page.should have_content("Enter your password")
  page.should have_content("ReEnter your password")  
end

When(/^I sign up wirh existed uin$/) do
  @user_info = {:name => "jiechen zhong", :email => "chen0209app@tamu.edu", :password => "321", :UIN => "123123123"}
  fill_in('Enter your full name', :with => @user_info[:name])
  fill_in('ReEnter your UIN', :with => @user_info[:UIN])
  fill_in('Enter your UIN', :with => @user_info[:UIN])
  fill_in('Enter your email', :with => @user_info[:email])
  fill_in('Enter your password', :with => @user_info[:password])
  fill_in('ReEnter your password', :with => @user_info[:password])
  click_button('Signup')
end
  
Then(/^I should recieve the warning massage$/) do
  if page.respond_to? :should
    page.should have_content("Warning: Your record is already there")
  else
    assert page.should have_content("Warning: Your record is already there")
  end
end


When(/^I fill in the form wongly, and then click SignUp$/) do 
  @user_info = {:name => "shuocun li", :email => "ginolee@tamu.edu", :password => "321", :UIN => "789789789"}
  fill_in('Enter your full name', :with => @user_info[:name])
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
    assert page.should have_content("The twice entered UIN and password must be same!")
  end
end

When(/^I fill in the form correctly, and then click SignUp$/) do 
  @user_info = {:name => "shuocun li", :email => "ginolee@tamu.edu", :password => "321", :UIN => "789789789"}
  fill_in('Enter your full name', :with => @user_info[:name])
  fill_in('ReEnter your UIN', :with => @user_info[:UIN])
  fill_in('Enter your UIN', :with => @user_info[:UIN])
  fill_in('Enter your email', :with => @user_info[:email])
  fill_in('Enter your password', :with => @user_info[:password])
  fill_in('ReEnter your password', :with => @user_info[:password])
  click_button('Signup')
end

Then(/^I should see my account create successfully$/) do
  page.should have_content("signed up successfully")
  page.should have_content("Login Page")
end

#...........2nd Senario........#

Given /the following students exist/ do |students|
  students.hashes.each do |student|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    # {"title"=>"Aladdin", "rating"=>"G", "release_date"=>"25-Nov-1992"}
    # Student.create(:name => 'Mian Qin', :uin => '123123123', :email => 'celery1124@tamu.edu', :password => '321',
    #                 :major => ' ', :classification => ' ')
    Student.create!(student)
  end
  #flunk "Unimplemented"
end

When(/^I am on the Login Page again$/) do
  visit('/')
  page.should have_content("Login Page")
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
    page.should have_content("Mian Qin(123123123)")
    page.should have_content("View Your Profile")
  else
    assert page.should have_content("Mian Qin(123123123)")
  end
  click_link('View Your Profile')
  # click_button('View Your Profile')
  # visit('/students/show')
end


Then(/^I should see my personal information$/) do
  page.should have_content("Full Name")
  page.should have_content("Major")
  page.should have_content("Classification")
  page.should have_content("Email")
end

And (/^I click OK$/) do
  click_button('Confirm')
end

Then (/^I should go back to dashboard$/) do
  page.should have_content("New Force Request")
  page.should have_content("Your Profile")
  page.should have_content("Change Your Password")
end

When(/^I click on New Force Request, I should see my profile auto-filled, and fill in the form, and then click Save Request$/) do
  click_link('New Force Request')
  @student_request = {:minor=>"None", :expected_graduation=>"2018 Fall", :request_semester=>"2017 Fall", :course_id=>"629", :Section_id => "600"}
  page.has_content?("123123123")
  # fill_in('UIN', :with => @student_request[:uin])
  # fill_in('Full Name*', :with => @student_request[:full_name])
  # select('CPSC', :from => 'Major*')
  # select('G7', :from => 'Classification')
  select(@student_request[:expected_graduation], from:'Expected Graduation*')
  select(@student_request[:request_semester], from:'Request Semester*')
  fill_in('Minor', :with => @student_request[:minor])
  fill_in('Course Id*', :with => @student_request[:course_id])
  fill_in('Section Id*', :with => @student_request[:Section_id]) 
  click_button('Save')
end


Then(/^I should see my info$/) do
  page.should have_content("Student Request was successfully created.")
  page.should have_content("629")
  page.should have_content("600")
end

When(/^I click on Withdraw$/) do
  click_button('Withdraw')
end

Then(/^I should not see that request on Student Dashboard Page$/) do
  page.has_content?("Student Request was successfully deleted")
end


And(/^I click change password button$/) do
  click_link('Change Your Password')
end

Then(/^I should be on change password page and fill it up$/) do
  page.has_content?("Enter your new password")
  
  @user_info = {:old => "321",  :new => "qwe"}
  fill_in('Enter your old password', :with => @user_info[:old])
  fill_in('Enter your new password', :with => @user_info[:new])
  fill_in('session[password2]', :with => @user_info[:new])
  
  click_button('Confirm')
end

When(/^I fill the old password wrongly$/) do
  @user_info = {:old => "qwe",  :new => "qwe"}
  fill_in('Enter your old password', :with => @user_info[:old])
  fill_in('Enter your new password', :with => @user_info[:new])
  fill_in('session[password2]', :with => @user_info[:new])
  
  click_button('Confirm')
end
  
Then(/^I stay on the page on recieve warining$/) do
  page.has_content?("The old password you enter is wrong!")
end

When(/^I fill the new password wrongly$/) do
  @user_info = {:old => "321",  :new => "qwe"}
  fill_in('Enter your old password', :with => @user_info[:old])
  fill_in('Enter your new password', :with => @user_info[:new])
  fill_in('session[password2]', :with => 'xxx')
  
  click_button('Confirm')
end
  
Then(/^I stay on the page on recieve another warining$/) do
  page.has_content?("The twice entered new password must be same!")
end

When(/^I withdraw this request$/) do
  # page.should have_content("Cancel")
  click_button('Cancel')
end

Then(/^I will back to student dashboard$/) do
  page.should have_content("View Your Profile")
end


And(/^I click logout button$/) do
  click_button('Logout')
end

Then(/^I should be on root page$/) do
  page.has_content?("Login Page")
end
  
And(/^I click forget password$/) do
  click_link('forget_password')
end

Then(/^I should be on reset password page$/) do
  page.has_content?("Reset Your Password")
end

When(/^I input my uin and click reset$/) do
  fill_in('Enter your UIN', :with => '123123123')
  # click_button('Reset')
end

