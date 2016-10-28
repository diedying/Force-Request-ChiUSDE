#spec/models/student_requests_model_spec.rb
require 'spec_helper'
require 'rails_helper'

describe StudentRequest do
    fixtures :student_requests
    it 'should include request_id' do
        student_request = student_requests(:john_doe)
        student_request.request_id == 1
    end
    it 'should include an uin' do
        student_request = student_requests(:john_doe)
        student_request.uin == 111222333
    end
    it 'should include full_name' do
        student_request = student_requests(:john_doe)
        student_request.full_name == "John Doe"
    end
    it 'should include a major' do
        student_request = student_requests(:john_doe)
        student_request.major == "CSCE"
    end
    it 'should include a classification' do
        student_request = student_requests(:john_doe)
        student_request.classification == "G7"
    end
    it 'should include an email' do
        student_request = student_requests(:john_doe)
        student_request.email == "johndoe@tamu.edu"
    end
    it 'should include request_semester' do
        student_request = student_requests(:john_doe)
        student_request.request_semester == "Fall"
    end
    it 'should include course_id' do
        student_request = student_requests(:john_doe)
        student_request.course_id == 606
    end
end
    