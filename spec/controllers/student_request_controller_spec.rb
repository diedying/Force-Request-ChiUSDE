require 'spec_helper'
require 'rails_helper'

describe StudentRequestsController, :type => :controller do
  describe "Create Student Request: " do
    context 'on properly formatted create request' do
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

    context 'on mal formatted create request' do
      it 'attempts to create a new a New Force Request' do

        #Given
        student = FactoryGirl.create(:student)
        student_request = FactoryGirl.create(:student_request)
        Student.should_receive(:where).once.and_return([student])


        #When
        post :create, :student_request => {:name => student_request.name}


        #Then
        expect(flash[:warning]).to eq("Uin can't be blank, Major can't be blank, Classification can't be blank, Request semester can't be blank, Request semester  is not a valid request semester, Course can't be blank, Course is invalid")
        assert_template 'new'
      end
    end
  end

  describe "Update Request" do
    context "When Student Request ACTIVE_STATE" do
      it "should update the state to WITHDRAWN_STATE" do
          #GIVEN
          student_request = FactoryGirl.create(:student_request)
          student_request.state = StudentRequest::ACTIVE_STATE
          StudentRequest.should_receive(:find).once.and_return(student_request)
          student_request.should_receive(:save!)

          #When
          put :update, :id => 14

          #THEN
          expect(student_request.state).to eq(StudentRequest::WITHDRAWN_STATE)
          expect(flash[:notice]).to eq("Student Request was successfully withdrawn.")
      end
    end
  end

  describe "Add Force Request" do
    context("When student doesn't exist") do
      it " should issue a flash warning" do
        Student.should_receive(:where).and_return([nil])

        post :add_force_request, :admin_request => {:uin => "Non-existent UIN"}

        expect(flash[:warning]).to eq('Student of UIN doesn\'t exist in system, please add him first!')

      end

      it "should redirect to the student_requests_adminprivileges_path" do
      end
    end
  end
end
