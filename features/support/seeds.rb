# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


student_requests = [{:uin => '126003824', :name => 'Mo Li', 
                     :major => 'Computer Engineering - CEEN', :classification => 'G7', :minor => 'CECN', :email => 'king_lm@tamu.edu', :phone => '9797797697', 
                     :expected_graduation => '2018 Fall', :request_semester => '2017 Fall',
                     :course_id => '026', :section_id => '101', :notes => 'Requirement for graduation.',:priority => 'Very High' , :state => 'Active'},
                     {:uin => '126003824', :name => 'Mo Li', 
                      :major => 'Computer Engineering - CEEN', :classification => 'G7', :minor => 'CECN', :email => 'king_lm@tamu.edu', :phone => '9797769279', 
                      :expected_graduation => '2018 Fall', :request_semester => '2017 Fall',
                      :course_id => '026', :section_id => '101', :notes => 'I need this course as my summer intern will deal with this.',:priority => 'Very High' , :state => 'Active'},
                      {:uin => '126003824', :name => 'Mo Li', 
                      :major => 'Computer Engineering - CEEN', :classification => 'G7', :minor => 'CECN', :email => 'king_lm@tamu.edu', :phone => '9793477979', 
                      :expected_graduation => '2018 Fall', :request_semester => '2017 Fall',
                      :course_id => '027', :section_id => '101', :notes => 'My research advisor has recommended this course.' ,:priority => 'Very High', :state => 'Active'},
                      
                      {:uin => '222111333', :name => 'Jiechen Zhong', 
                      :major => 'CEEN', :classification => 'G8', :minor => 'MATH', :email => 'chen0209app@tamu.edu', :phone => '9797797900', 
                      :expected_graduation => '2018 Fall', :request_semester => '2017 Fall',
                      :course_id => '026', :section_id => '101', :notes => 'I am interested in CS026 as it is my field of research.' ,:priority => 'Very High', :state => 'Active'},
                      {:uin => '222111333', :name => 'Jiechen Zhong', 
                      :major => 'CEEN', :classification => 'G8', :minor => 'PHYS', :email => 'chen0209app@tamu.edu', :phone => '9797797900', 
                      :expected_graduation => '2018 Fall', :request_semester => '2017 Fall',
                      :course_id => '028', :section_id => '101', :notes => 'I need this subject to graduate.',:priority => 'Very High' , :state => 'Active'}]

majors = [{:major_id => 'CPSC'}, {:major_id => 'CECN'}, {:major_id => 'CEEN'}, {:major_id => 'ELEN'}, {:major_id => 'APMS'},
            {:major_id => 'CPSL'}, {:major_id => 'CECL'}, {:major_id => 'CEEL'}, {:major_id => 'Others'}]
            
admins = [{:uin => '123456789', :name => 'admin', :password => 'tamu2017'}]

students = [{uin: "126003824", password: "123123", major: "Computer Engineering - CEEN", classification: "G7-Graduate, Master's Level", name: "Mo Li", email: "king_lm@tamu.edu"},
            {uin: "123123123", password: "321", major: "Computer Engineering - CEEN", classification: "G8-Graduate", name: "Mian Qin", email: "celery1124@tamu.edu"},
            {uin: "222111333", password: "zxc", major: "Computer Engineering - CEEN", classification: "G7-Graduate, Master's Level", name: "Jiechen Zhong", email: "chen0209app@tamu.edu"}]

# students = []
students.each do |student|
   Student.create!(student) 
end

student_requests.each do |requests|
    StudentRequest.create!(requests)
end

majors.each do |record|
  Major.create!(record)
end

admins.each do |record|
  Admin.create!(record)
end

