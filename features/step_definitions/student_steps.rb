Given /the following students exist/ do |students_table|
    students_table.hashes.each do |student|
        @tmp = Student.create student
        @tmp.email_activate
    end
end

When(/^I am a student want to sign up for an account$/) do
  visit('/')
  page.should have_content("Login Page")
end

Then(/^I click on Sign Up$/) do
  click_link('Sign Up')
end

Then(/^I will be on the Sign Up page$/) do
  page.should have_content("Enter LastName")
  page.should have_content("Enter FirstName")
  page.should have_content("Enter your UIN")
  page.should have_content("ReEnter your UIN")
  page.should have_content("Select your Major")
  page.should have_content("Select your classification")
  page.should have_content("Enter your email")
  page.should have_content("Enter your password")
  page.should have_content("ReEnter your password")  
end



When(/^I fill in the form incorrectly$/) do 
  @user_info = {:lastname => "yang", :firstname =>"junqi", :email => "junqiyang@tamu.edu", :password => "123456", :UIN => "789789789"}
  fill_in('Enter LastName', :with => @user_info[:last])
  fill_in('Enter FirstName', :with => @user_info[:first])
  fill_in('ReEnter your UIN', :with => "000000000")
  fill_in('Enter your UIN', :with => @user_info[:UIN])
  fill_in('Enter your email', :with => @user_info[:email])
  fill_in('Enter your password', :with => @user_info[:password])
  fill_in('ReEnter your password', :with => @user_info[:password])
end

When(/^I fill in with exsiting account information$/) do 
   @user_info = {:lastname => "Will", :firstname =>"Adam", :email => "Will@tamu.edu", :password => "456789", :UIN => "789789789"}
  fill_in('Enter LastName', :with => @user_info[:last])
  fill_in('Enter FirstName', :with => @user_info[:first])
  fill_in('ReEnter your UIN', :with => @user_info[:UIN])
  fill_in('Enter your UIN', :with => @user_info[:UIN])
  fill_in('Enter your email', :with => @user_info[:email])
  fill_in('Enter your password', :with => @user_info[:password])
  fill_in('ReEnter your password', :with => @user_info[:password])
end

When(/^I fill in the form correctly then SignUp$/) do 
  @user_info = {:lastname => "yang", :firstname =>"junqi", :email => "junqiyang@tamu.edu", :major => "Computer Science", :classification => "G", :password => "321312", :UIN => "789789789"}
  fill_in('Enter LastName', :with => @user_info[:last])
  fill_in('Enter FirstName', :with => @user_info[:first])
  fill_in('ReEnter your UIN', :with => @user_info[:UIN])
  fill_in('Enter your UIN', :with => @user_info[:UIN])
  fill_in('Enter your email', :with => @user_info[:email])
  select "G", :from => "Select your classification"
  select "Computer Science", :from => "Select your Major"#something wrong here, maybe we just make major a list???
  fill_in('Enter your password', :with => @user_info[:password])
  fill_in('ReEnter your password', :with => @user_info[:password])
  click_button('Signup')
 end

And(/^I click SignUp$/) do
  click_button('Signup')
end

Then (/^I should stay on the same page$/) do
  page.should have_content("Enter LastName")
  page.should have_content("Enter FirstName")
  page.should have_content("Enter your UIN")
  page.should have_content("ReEnter your UIN")
  page.should have_content("Select your Major")
  page.should have_content("Select your classification")
  page.should have_content("Enter your email")
  page.should have_content("Enter your password")
  page.should have_content("ReEnter your password")  
end


And(/^recieve a warning massage$/) do
  if page.respond_to? :should
    page.should have_content("The twice entered UIN and password must be same!")
  else
    assert page.should have_content("The twice entered UIN and password must be same!")
  end
end

Then(/^I recieve another warning massage$/) do
  if page.respond_to? :should
    page.should have_content("You have already signed up")
  else
    assert page.should have_content("You have already signed up")
  end
end


Then(/^I should see my account create successfully$/) do
  page.should have_content("signed up successfully")
  page.should have_content("Login Page")
end



When(/^I am on the Login Page$/) do
  visit('/')
  page.should have_content("Login Page")
end

And(/^I fill in correct login info/) do
  @user_info = {:UIN => "789789789",  :password => "456789"}
  fill_in('Enter your uin', :with => @user_info[:UIN])
  fill_in('Enter your password', :with => @user_info[:password])
end

And(/^I click login/) do
  click_button('Login')
end

And(/^I should be on Student Dashboard Page and click profile$/) do
  # page.has_content?("Howdy! Welcome back Mian Qin")
  # click_button('Your Profile')
  if page.respond_to? :should
    page.should have_content("Adam will(789789789)")
    page.should have_content("View Your Profile")
  else
    assert page.should have_content("Adam will(789789789)")
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
  @student_request = {:minor=>"None", :expected_graduation=>"2018 Fall", :request_semester=>"2018 Fall", :course_id=>"629", :section_id => "600"}
  page.has_content?("123123123")
  select(@student_request[:expected_graduation], from:'Expected Graduation*')
  select(@student_request[:request_semester], from:'Request Semester*')
  fill_in('Minor', :with => @student_request[:minor])
  fill_in('Course Id*', :with => @student_request[:course_id])
  fill_in('Section Id*', :with => @student_request[:section_id]) 
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
  click_button('Change Your Password')
end

Then(/^I should be on change password page and fill it up$/) do
  @user_info = {:old => "456789",  :new => "qwerty"}
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
  @user_info = {:old => "456789",  :new => "qwerty"}
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

















