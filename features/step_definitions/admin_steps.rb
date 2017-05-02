Given(/^I am on the Login Page as admin$/) do
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

And(/^I use admin account to login$/) do
  choose('session_user_admin')
  @user_info = {:UIN => "123456789",  :password => "tamu2017"}
  fill_in('Enter your uin', :with => @user_info[:UIN])
  fill_in('Enter your password', :with => @user_info[:password])
  click_button('Login')
end

Then(/^I should be on Admin View page$/) do
    page.should have_content("Admin Dashboard Page")
    page.should have_content("Howdy! Welcome back admin")
end
    
    
And(/^I should see all requests here$/) do
    page.should have_content("Mo Li")
    page.should have_content("More Actions")
end


When(/^I click More Actions$/) do
    page.should have_content("More Actions")
    click_link('More Actions')
end
    
Then(/^I should go to action page$/) do
     page.should have_content("Add New Force Admin")
     page.should have_content("Add New Force Request to System")  
     page.should have_content("Add New Student to System")
end

When(/^I add a new admin$/) do
    click_link('Add New Force Admin')
end

And(/^I fill the info of new admin$/) do
    page.should have_content("Uin of new admin")  
    @user_info = {:UIN => "111222333", :name => "walker",  :password => "qwe"}
    fill_in('admin_request_uin', :with => @user_info[:UIN])
    fill_in('admin_request_name', :with => @user_info[:name])
    fill_in('admin_request_password', :with => @user_info[:password])
    click_button('button_confirm')
end

Then(/^I should back to admin dashboard$/) do
    page.should have_content("Admin Dashboard Page")
end


When(/^I click add a new student$/) do
    click_link('Add New Student to System')
end

And(/^I fill the info of new student$/) do
    page.should have_content("lassification of student (U1,U3,G7,G8,etc):") 
    @user_info = {:UIN => "777888999", :name => "Xiaoer Wang",  :email => "qweasd@tamu.edu", :major => 'CEEL', :classification => 'U1'}
    fill_in('session_name', :with => @user_info[:name])
    fill_in('session_uin', :with => @user_info[:UIN])
    fill_in('session_uin2', :with => @user_info[:UIN])
    fill_in('session_email', :with => @user_info[:email])
    # select(@user_info[:major], from:'session_major')
    # select(@user_info[:classification], from:'session_classification')
    click_button('button_confirm')
end

When(/^I click add a new force request to system$/) do
    click_link('Add New Force Request to System')
end

And(/^I fill the info of new request$/) do
    @user_info = {:UIN => "777888999", :grad_year => "2017 Fall",  :Req_sem => "2017 Fall", :course_id => '314', :section_id => '100'}
    fill_in('UIN of student*', :with => @user_info[:UIN])
    select(@user_info[:grad_year], from:'Expected Graduation*')
    select(@user_info[:Req_sem], from:'Request Semester*')
    fill_in('Course Id*', :with => @user_info[:course_id])
    fill_in('Section Id*', :with => @user_info[:section_id])
    
    click_button('button_confirm')
end


 
When(/^I click archive all and see a pop window and click ok$/) do
    pop_window = window_opened_by do
        click_link('Archive All Force Request Data to Archival Database')
    end
    within_window pop_window do
      click_button 'OK'
    end
end


When(/^I filter the requests$/) do
    check('state_sel_Rejected')
    check('state_sel_Approved')
    within('div[class = filter_form1]')  do 
        click_button('Refresh')
    end
end

When(/^I filter the requests with priority$/) do
    uncheck('priority_sel_High')
    uncheck('priority_sel_Low')
    within('div[class = filter_form1]')  do 
        click_button('Refresh')
    end
end


Then(/^I have the requests in desired domain$/) do
    page.should have_content("Admin Dashboard Page")
end

When(/^I click course name button$/) do
    click_button('Course Name 026')
end

Then(/^the page collapse$/) do
    page.has_content?('	FRS44fe477f6025c48c6fb9')
end

When(/^I select state and priority and click update$/) do
    within('div[id = student_requests_026]')  do
        select('Approved', from:'multi_state_sel')
        select('Very High', from:'multi_priority_sel')
        click_button('Update Selected')
        click_link('Download as Excel Sheet')
    end
end


Then(/^I Should see the desired domain of one class$/) do
    page.should have_content("request_id")
    # within('div[id = main]')  do
    #     click_on('download_table')
    # end
end


When(/^I click the title$/) do
    click_on('CSE Force Request System')
end

Then(/^I should be on login page$/) do
    page.should have_content("Login Page")
end