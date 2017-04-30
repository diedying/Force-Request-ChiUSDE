majors = [{:major_id => 'CPSC'}, {:major_id => 'CECN'}, {:major_id => 'CEEN'}, {:major_id => 'ELEN'}, {:major_id => 'APMS'},
            {:major_id => 'CPSL'}, {:major_id => 'CECL'}, {:major_id => 'CEEL'}, {:major_id => 'Others'}]
            
admins = [{:uin => '123456789', :name => 'admin', :password => 'tamu2017'}]

students = [{uin: "126003824", password: "123123", major: "Computer Engineering - CEEN", classification: "G7-Graduate, Master's Level", name: "Mo Li", email: "king_lm@tamu.edu"}]
# students = []
students.each do |student|
   Student.create!(student) 
end

# student_requests.each do |record|
#   StudentRequest.create!(record)
# end

majors.each do |record|
  Major.create!(record)
end

admins.each do |record|
  Admin.create!(record)
end