# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


student_requests = [{:uin => '425008306', :full_name => 'Adil Hamid Malla', 
                     :major => 'CSE', :classification => 'A', :minor => 'VISION', :email => 'adil@gmail.com', :phone => '97977979', 
                     :expected_graduation => '2018', :request_semester => 'fall',
                     :course_id => '026', :section_id => '101', :notes => 'hello mar ja' , :state => 'active'},
                     {:uin => '225008988', :full_name => 'Bhavik Ameta', 
                      :major => 'CSE', :classification => 'A', :minor => 'Database', :email => 'bhavik@tamu.edu', :phone => '97977979', 
                      :expected_graduation => '2018', :request_semester => 'fall',
                      :course_id => '026', :section_id => '101', :notes => 'superman' , :state => 'active'},
                      {:uin => '225008989', :full_name => 'Shubham Jain', 
                      :major => 'CSE', :classification => 'A', :minor => 'Image Processing', :email => 'shubham7jain@tamu.edu', :phone => '97977979', 
                      :expected_graduation => '2018', :request_semester => 'fall',
                      :course_id => '027', :section_id => '101', :notes => 'This force request is at number 1 in queue :P' , :state => 'active'},
                       {:uin => '225008989', :full_name => 'ShubHHHham Jain', 
                      :major => 'CSE', :classification => 'A', :minor => 'Image Processing', :email => 'shubham7jain@tamu.edu', :phone => '97977979', 
                      :expected_graduation => '2018', :request_semester => 'fall',
                      :course_id => '027', :section_id => '101', :notes => 'This force request is at number 1 in queue :P' , :state => 'active'},
                       {:uin => '225008989', :full_name => 'Shubhamkjkj Jain', 
                      :major => 'CSE', :classification => 'A', :minor => 'Image Processing', :email => 'shubham7jain@tamu.edu', :phone => '97977979', 
                      :expected_graduation => '2018', :request_semester => 'fall',
                      :course_id => '028', :section_id => '101', :notes => 'This force request is at number 1 in queue :P' , :state => 'active'}]

student_requests.each do |record|
  StudentRequest.create!(record)
end
