Given /the following students exist/ do |students_table|
    students_table.hashes.each do |student|
        @tmp = Student.create student
        @tmp.email_activate
    end
end

Given(/^I am a student want to sign up for an account$/) do
  visit('/')
  page.should have_content("Login Page")
end

When(/^I click on Sign Up$/) do
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



When(/^I enter two different password or UIN information$/) do 
  @user_info = {:lastname => "yang", :firstname =>"junqi", :email => "junqiyang@tamu.edu", :password => "123456", :UIN => "789789789"}
  fill_in('Enter LastName', :with => @user_info[:lastname])
  fill_in('Enter FirstName', :with => @user_info[:firstname])
  fill_in('ReEnter your UIN', :with => "000000000")
  fill_in('Enter your UIN', :with => @user_info[:UIN])
  fill_in('Enter your email', :with => @user_info[:email])
  fill_in('Enter your password', :with => @user_info[:password])
  fill_in('ReEnter your password', :with => @user_info[:password])
end

When(/^I use a UIN which already been used to sign up$/) do 
  @user_info = {:lastname => "Will", :firstname =>"Adam", :email => "Will@tamu.edu", :password => "456789", :UIN => "789789789"}
  fill_in('Enter LastName', :with => @user_info[:lastname])
  fill_in('Enter FirstName', :with => @user_info[:firstname])
  fill_in('ReEnter your UIN', :with => @user_info[:UIN])
  fill_in('Enter your UIN', :with => @user_info[:UIN])
  fill_in('Enter your email', :with => @user_info[:email])
  fill_in('Enter your password', :with => @user_info[:password])
  fill_in('ReEnter your password', :with => @user_info[:password])
end

When(/^I enter a email does not exsiting in TAMU system$/) do 
 @user_info = {:lastname => "yang", :firstname =>"junqi", :email => "junqiyang@email.tamu.edu", :password => "123456", :UIN => "789789789"}
  fill_in('Enter LastName', :with => @user_info[:lastname])
  fill_in('Enter FirstName', :with => @user_info[:firstname])
  fill_in('ReEnter your UIN', :with => @user_info[:UIN])
  fill_in('Enter your UIN', :with => @user_info[:UIN])
  fill_in('Enter your email', :with => @user_info[:email])
  fill_in('Enter your password', :with => @user_info[:password])
  fill_in('ReEnter your password', :with => @user_info[:password])
end


When(/^I enter correct information$/) do 
  @user_info = {:lastname => "yang", :firstname =>"junqi", :email => "junqiyang@tamu.edu", :major => "Computer Science", :classification => "G", :password => "321312", :UIN => "789789789"}
  fill_in 'Enter LastName', :with => @user_info[:lastname]
  fill_in 'Enter FirstName', :with => @user_info[:firstname]
  fill_in 'ReEnter your UIN', :with => @user_info[:UIN]
  fill_in 'Enter your UIN', :with => @user_info[:UIN]
  fill_in 'Enter your email', :with => @user_info[:email]
  select "G", :from => "Select your classification"
  select "Computer Science", :from => "Select your Major"
  fill_in('Enter your password', :with => @user_info[:password])
  fill_in('ReEnter your password', :with => @user_info[:password])
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

Then (/^I should return to root page$/) do
  page.should have_content("Login Page")
end


And(/^I should recieve a mismatch warning massage$/) do
    page.should have_content("Those UINs or passwords didn't match. Try agagin.")
end

And(/^I should recieve a account-exist warning massage$/) do
    page.should have_content("An account associated with")
    page.should have_content("has been created.")
end

Then(/^I should recieve a no-record warning massage$/) do
    page.should have_content("Your name and email didn't match")
end


Then(/^I should see my account create successfully$/) do
  page.should have_content("An account has been created")
  page.should have_content("Login Page")
end





















