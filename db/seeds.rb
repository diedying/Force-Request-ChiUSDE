# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


student_requests = [{:uin => '425008306', :full_name => 'Adil Hamid Malla', 
                     :major => 'CPSC', :classification => 'U2', :minor => 'CECN', :email => 'adil@gmail.com', :phone => '9797797697', 
                     :expected_graduation => '2018 Spring', :request_semester => '2017 Fall',
                     :course_id => '026', :section_id => '101', :notes => 'Requirement for graduation.',:priority => 'Very High' , :state => 'Active'},
                     {:uin => '225008988', :full_name => 'Bhavik Ameta', 
                      :major => 'CPSC', :classification => 'G7', :minor => 'MECH', :email => 'bhavik@tamu.edu', :phone => '9797769279', 
                      :expected_graduation => '2018 Summer', :request_semester => '2017 Spring',
                      :course_id => '026', :section_id => '101', :notes => 'I need this course as my summer intern will deal with this.',:priority => 'Very High' , :state => 'Active'},
                      {:uin => '225008989', :full_name => 'Shubham Jain', 
                      :major => 'CPSC', :classification => 'G8', :minor => 'CVEN', :email => 'shubham7jain@tamu.edu', :phone => '9793477979', 
                      :expected_graduation => '2018 Fall', :request_semester => '2017 Summer',
                      :course_id => '027', :section_id => '101', :notes => 'My research advisor has recommended this course.' ,:priority => 'Very High', :state => 'Active'},
                       {:uin => '225008989', :full_name => 'Shubham Jain', 
                      :major => 'CPSC', :classification => 'G8', :minor => 'MATH', :email => 'shubham7jain@tamu.edu', :phone => '9797797900', 
                      :expected_graduation => '2017 Fall', :request_semester => '2017 Fall',
                      :course_id => '026', :section_id => '101', :notes => 'I am interested in CS026 as it is my field of research.' ,:priority => 'Very High', :state => 'Active'},
                       {:uin => '225008989', :full_name => 'Shubham Jain', 
                      :major => 'CPSC', :classification => 'G8', :minor => 'PHYS', :email => 'shubham7jain@tamu.edu', :phone => '9792377979', 
                      :expected_graduation => '2017 Fall', :request_semester => '2017 Spring',
                      :course_id => '028', :section_id => '101', :notes => 'I need this subject to graduate.',:priority => 'Very High' , :state => 'Active'},
                      {:uin => '525008931', :full_name => 'Aditya Nanjangud', 
                     :major => 'CPSC', :classification => 'G8', :minor => 'CECN', :email => 'aditya@gmail.com', :phone => '9797797697', 
                     :expected_graduation => '2018 Spring', :request_semester => '2017 Fall',
                     :course_id => '026', :section_id => '101', :notes => 'I need this course since this is my last semester',:priority => 'Very High' , :state => 'Active'},
                     {:uin => '525008931', :full_name => 'Aditya Nanjangud', 
                     :major => 'CPSC', :classification => 'G8', :minor => 'CECN', :email => 'aditya@gmail.com', :phone => '9797797697', 
                     :expected_graduation => '2018 Spring', :request_semester => '2017 Fall',
                     :course_id => '027', :section_id => '101', :notes => 'I need this course since this is my last semester',:priority => 'Very High' , :state => 'Active'},
                     {:uin => '525008931', :full_name => 'Aditya Nanjangud', 
                     :major => 'CPSC', :classification => 'G8', :minor => 'CECN', :email => 'aditya@gmail.com', :phone => '9797797697', 
                     :expected_graduation => '2018 Spring', :request_semester => '2017 Fall',
                     :course_id => '028', :section_id => '101', :notes => 'I need this course since this is my last semester',:priority => 'Very High' , :state => 'Active'},
                     {:uin => '525008932', :full_name => 'Navneet Gupta', 
                     :major => 'CPSC', :classification => 'G8', :minor => 'CECN', :email => 'navneet@gmail.com', :phone => '4693889840', 
                     :expected_graduation => '2018 Spring', :request_semester => '2017 Fall',
                     :course_id => '026', :section_id => '101', :notes => 'I need this course since this is my last semester',:priority => 'High' , :state => 'Active'},
                     {:uin => '525008932', :full_name => 'Navneet Gupta', 
                     :major => 'CPSC', :classification => 'G8', :minor => 'CECN', :email => 'navneet@gmail.com', :phone => '4693889840', 
                     :expected_graduation => '2018 Spring', :request_semester => '2017 Fall',
                     :course_id => '027', :section_id => '101', :notes => 'I need this course since this is my last semester',:priority => 'High' , :state => 'Active'},
                     {:uin => '525008932', :full_name => 'Navneet Gupta', 
                     :major => 'CPSC', :classification => 'G8', :minor => 'CECN', :email => 'navneet@gmail.com', :phone => '4693889840', 
                     :expected_graduation => '2018 Spring', :request_semester => '2017 Fall',
                     :course_id => '028', :section_id => '101', :notes => 'I need this course since this is my last semester',:priority => 'High' , :state => 'Approved'}]

majors = [{:major_id => 'CPSC'}, {:major_id => 'CECN'}, {:major_id => 'CEEN'}, {:major_id => 'ELEN'}, {:major_id => 'APMS'},
            {:major_id => 'CPSL'}, {:major_id => 'CECL'}, {:major_id => 'CEEL'}, {:major_id => 'Others'}]
            
# admins = [{:uin => '123'}, {:uin => '123456789'}, {:uin => '456789123'}, {:uin => '987654321'}]
admins = [{:uin => '123', :name => 'admin', :password => '123'}]

users = [{:uin => '111', :name => 'shuocun', :email => 'ginolee@tamu.edu', :password => 'Shuo0727~~'},
         {:uin => '222', :name => 'Mo Li', :email => 'king_lm@tamu.edu', :password => '123'}]
students = [{:uin => '126003824', :password => '123123', :name => 'Mo Li', :email => 'king_lm@tamu.edu'},
            {:uin => '111111111', :password => '123456', :name => 'ROBOT', :email => 'robot@tamu.edu'}
            ]
students.each do |student|
   Student.create!(student) 
end
student_requests.each do |record|
  StudentRequest.create!(record)
end

majors.each do |record|
  Major.create!(record)
end

admins.each do |record|
  Admin.create!(record)
end

users.each do |record|
  User.create!(record)
end