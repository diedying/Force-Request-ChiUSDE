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
          student_request.should_receive(:destroy)

          #When
          put :update, :id => 14

          #THEN
          expect(student_request.state).to eq(StudentRequest::WITHDRAWN_STATE)
          expect(flash[:notice]).to eq("Request was successfully withdrawn.")
      end
    end
  end

  describe "Add Force Request" do
    context("When UIN doesn't exist") do
      it " should issue a flash warning" do
        Student.should_receive(:where).and_return([nil])

        post :add_force_request, :admin_request => {:uin => "Non-existent UIN"}

        expect(flash[:warning]).to eq('Student of UIN doesn\'t exist in system, please add him first!')

      end

      it "should redirect to the student_requests_adminprivileges_path" do
        Student.should_receive(:where).and_return([nil])

        post :add_force_request, :admin_request => {:uin => "Non-existent UIN"}

        assert_response :redirect, :action => 'students_show_path'
      end
    end

    context("When UIN exists") do
      context("When student is saved") do
        before :each do
          student = FactoryGirl.create(:student)
          student_request = FactoryGirl.create(:student_request)
          Student.should_receive(:where).and_return([student])

          post :add_force_request, :admin_request => {:uin => student_request.uin},
                                   :student_request => {:name => student_request.name,
                                             :uin => student_request.uin,
                                             :major => student_request.major,
                                             :classification => student_request.classification,
                                             :email => student_request.email,
                                             :request_semester => student_request.request_semester,
                                             :course_id => student_request.course_id,
                                             :phone => student_request.phone}

        end
        it "should issue a flash notice" do
          expect(flash[:notice]).to eq("Student Request was successfully created.")
        end

        it "should redirect to the the Admin Privileges Path" do
          assert_response :redirect, :action => 'student_requests_adminprivileges_path'
        end


      end

      context("When student cannot be saved") do

        before :each do
          student = FactoryGirl.create(:student)
          student_request = FactoryGirl.create(:student_request)
          Student.should_receive(:where).and_return([student])

          post :add_force_request, :admin_request => {:uin => student_request.uin},
                                   :student_request => {:name => student_request.name}
        end

        it "should issue a flash warning" do
          expect(flash[:warning]).to eq("Major can't be blank, Classification can't be blank, Request semester can't be blank, Request semester  is not a valid request semester, Course can't be blank, Course is invalid")
        end

        it "should redirect to the to the admin privelages path" do

          assert_response :redirect, :action => 'student_requests_adminprivileges_path'
        end

      end
    end
  end


  describe "Admin Actions" do
    it "should approve a student request" do
      #Given
      student_request = FactoryGirl.create(:student_request)
      StudentRequest.should_receive(:find).with("14").once.and_return(student_request)
      student_request.should_receive(:save)

      #When
      put :approve, :id => 14

      #Then
      expect(student_request.state).to eq(StudentRequest::APPROVED_STATE)
      assert_response :redirect, :action => 'student_requests_adminview_path'
    end

    it "should Reject a student request" do
      #Given
      student_request = FactoryGirl.create(:student_request)
      StudentRequest.should_receive(:find).with("14").once.and_return(student_request)
      student_request.should_receive(:save)

      #When
      put :reject, :id => 14

      #Then
      expect(student_request.state).to eq(StudentRequest::REJECTED_STATE)
      assert_response :redirect, :action => 'student_requests_adminview_path'
    end

    it "should hold a student request" do
      #Given
      student_request = FactoryGirl.create(:student_request)
      StudentRequest.should_receive(:find).with("14").once.and_return(student_request)
      student_request.should_receive(:save)

      #When
      put :hold, :id => 14

      #Then
      expect(student_request.state).to eq(StudentRequest::HOLD_STATE)
      assert_response :redirect, :action => 'student_requests_adminview_path'
    end
  end
end
