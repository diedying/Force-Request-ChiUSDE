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
  fill_in('Enter LastName', :with => @user_info[:lastname])
  fill_in('Enter FirstName', :with => @user_info[:firstname])
  fill_in('ReEnter your UIN', :with => "000000000")
  fill_in('Enter your UIN', :with => @user_info[:UIN])
  fill_in('Enter your email', :with => @user_info[:email])
  fill_in('Enter your password', :with => @user_info[:password])
  fill_in('ReEnter your password', :with => @user_info[:password])
end

When(/^I fill in with exsiting account information$/) do 
  @user_info = {:lastname => "Will", :firstname =>"Adam", :email => "Will@tamu.edu", :password => "456789", :UIN => "789789789"}
  fill_in('Enter LastName', :with => @user_info[:lastname])
  fill_in('Enter FirstName', :with => @user_info[:firstname])
  fill_in('ReEnter your UIN', :with => @user_info[:UIN])
  fill_in('Enter your UIN', :with => @user_info[:UIN])
  fill_in('Enter your email', :with => @user_info[:email])
  fill_in('Enter your password', :with => @user_info[:password])
  fill_in('ReEnter your password', :with => @user_info[:password])
end

When(/^I fill in the form correctly then SignUp$/) do 
  @user_info = {:lastname => "yang", :firstname =>"junqi", :email => "junqiyang@tamu.edu", :major => "Computer Science", :classification => "G", :password => "321312", :UIN => "789789789"}
  fill_in 'Enter LastName', :with => @user_info[:lastname]
  fill_in 'Enter FirstName', :with => @user_info[:firstname]
  fill_in 'ReEnter your UIN', :with => @user_info[:UIN]
  fill_in 'Enter your UIN', :with => @user_info[:UIN]
  fill_in 'Enter your email', :with => @user_info[:email]
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
  page.should have_content("activate your account")
  page.should have_content("Login Page")
end





















