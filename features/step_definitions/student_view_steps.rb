# features/step_definitions/contact_form_steps.rb
Given(/^I am on the Student Request page$/) do
  visit('/contact')
end

When(/^I log in$/) do
  fill_in('Message', :with => 'Hello there!')
  find('Submit').click
end

Then(/^I should see my requests$/) do
  page.has_content?("Thank you")
end