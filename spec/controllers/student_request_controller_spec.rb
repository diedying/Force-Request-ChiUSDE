require 'spec_helper'
require 'rails_helper'

describe StudentRequestsController, :type => :controller do
  describe "Create Student Request: " do
    it 'creates a student request' do

      #Given
      student = FactoryGirl.create(:student)
      student_request = FactoryGirl.create(:student_request)
      Student.should_receive(:where).once.and_return([student])
      StudentMailer.should_receive(:confirm_force_request).once.and_return( double("Mailer", :deliver => true) );


      #When
      post :create, :student_request => {:name => student_request.name,
                                         :uin => student_request.uin,
                                         :major => student_request.major,
                                         :classification => student_request.classification,
                                         :email => student_request.email,
                                         :request_semester => student_request.request_semester,
                                         :course_id => student_request.course_id,
                                         :phone => student_request.phone}

      #Then
      expect(flash[:notice]).to eq("Student Request was successfully created.")
      assert_response :redirect, :action => 'students_show_path'


    end
  end
end
