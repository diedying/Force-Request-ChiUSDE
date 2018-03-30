############################################################################################################
#view profile
############################################################################################################
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

############################################################################################################
#new force request
############################################################################################################


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


############################################################################################################
#change password
############################################################################################################

And(/^I click change password button$/) do
  click_link('Change Your Password')
end

Then(/^I should be on change password page$/) do
  page.should have_content("Change Your Password")
  page.should have_content("Enter your old password") 
end


Then (/^I should read a successful message$/) do
  page.should have_content("Your password has been changed!") 
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

When(/^I fill the form and confirm$/) do
  @user_info = {:old => "456789",  :new => "qwerty"}
  fill_in 'Enter your old password', with:"456789"
  fill_in('Enter your new password', :with => @user_info[:new])
  fill_in('session[password2]', :with => @user_info[:new])
  click_button('Confirm')
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




############################################################################################################
#log out
############################################################################################################
And(/^I click logout button$/) do
  click_button('Logout')
end


Then(/^I should be on root page$/) do
  page.has_content?("Login Page")
end
  
  
############################################################################################################
#forget password
############################################################################################################

  
  
And(/^I click forget password$/) do
  click_link('forget_password')
end

Then(/^I should be on reset password page$/) do
  page.has_content?("Reset Your Password")
end

When(/^I input my uin and click reset$/) do
  fill_in('Enter your UIN', :with => '123123123')
  click_button('Reset')
end

Then (/^I should see a message$/) do
  page.has_content?("Please check your tamu email to reset your password!")
end










