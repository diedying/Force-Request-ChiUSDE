# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


student_requests = [{:uin => '425008306', :full_name => 'Adil Hamid Malla', 
                     :major => 'CPSC', :classification => 'U2', :minor => 'VISION', :email => 'adil@gmail.com', :phone => '97977979', 
                     :expected_graduation => '2018 Spring', :request_semester => '2017 Fall',
                     :course_id => '026', :section_id => '101', :notes => 'hello mar ja',:priority => 'Very High' , :state => 'Active'},
                     {:uin => '225008988', :full_name => 'Bhavik Ameta', 
                      :major => 'CPSC', :classification => 'G7', :minor => 'Database', :email => 'bhavik@tamu.edu', :phone => '97977979', 
                      :expected_graduation => '2018 Summer', :request_semester => '2017 Spring',
                      :course_id => '026', :section_id => '101', :notes => 'superman',:priority => 'Very High' , :state => 'Active'},
                      {:uin => '225008989', :full_name => 'Shubham Jain', 
                      :major => 'CPSC', :classification => 'G8', :minor => 'Image Processing', :email => 'shubham7jain@tamu.edu', :phone => '97977979', 
                      :expected_graduation => '2018 Fall', :request_semester => '2017 Summer',
                      :course_id => '027', :section_id => '101', :notes => 'This force request is at number 1 in queue :P' ,:priority => 'Very High', :state => 'Active'},
                       {:uin => '225008989', :full_name => 'ShubHHHham Jain', 
                      :major => 'CECN', :classification => 'U4', :minor => 'Image Processing', :email => 'shubham7jain@tamu.edu', :phone => '97977979', 
                      :expected_graduation => '2017 Fall', :request_semester => '2017 Fall',
                      :course_id => '027', :section_id => '101', :notes => 'This force request is at number 1 in queue :P' ,:priority => 'Very High', :state => 'Active'},
                       {:uin => '225008989', :full_name => 'Shubhamkjkj Jain', 
                      :major => 'Others', :classification => 'U3', :minor => 'Image Processing', :email => 'shubham7jain@tamu.edu', :phone => '97977979', 
                      :expected_graduation => '2017 Fall', :request_semester => '2017 Spring',
                      :course_id => '028', :section_id => '101', :notes => 'This force request is at number 1 in queue :P',:priority => 'Very High' , :state => 'Active'}]

majors = [{:major_id => 'CPSC'}, {:major_id => 'CECN'}, {:major_id => 'CEEN'}, {:major_id => 'ELEN'}, {:major_id => 'APMS'},
            {:major_id => 'CPSL'}, {:major_id => 'CECL'}, {:major_id => 'CEEL'}, {:major_id => 'Others'}]

student_requests.each do |record|
  StudentRequest.create!(record)
end

majors.each do |record|
  Major.create!(record)
end