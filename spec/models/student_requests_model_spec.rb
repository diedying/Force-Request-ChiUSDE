#spec/models/student_requests_model_spec.rb
require 'spec_helper'
require 'rails_helper'

describe StudentRequest do
    # fixtures :student_requests
    before :each do
      @student_request = FactoryGirl.create(:student_request)
    end
    it 'should include an uin' do
        @student_request.uin == "345345345"
    end

    it 'should include name' do
        @student_request.name == "John Doe"
    end
    it 'should include a major' do
        @student_request.major == "CSCE"
    end
    it 'should include a classification' do
        @student_request.classification == "G8"
    end
    it 'should include an email' do
        @student_request.email == "johndoe@tamu.edu"
    end
    it 'should include request_semester' do
        @student_request.request_semester == "2019 Spring"
    end
    it 'should include course_id' do
        @student_request.course_id == "633"
    end

    it 'should include phone' do
      @student_request.phone == "9793459799"
    end
end
