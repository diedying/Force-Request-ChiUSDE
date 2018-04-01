# This will guess the User class
FactoryGirl.define do
  factory :student_request do
    name "John Doe"
    uin "345345345"
    major "CSCE"
    classification "G8"
    email "johndoe@tamu.edu"
    request_semester "2019 Spring"
    course_id "633"
    phone "9793459799"
  end
end
