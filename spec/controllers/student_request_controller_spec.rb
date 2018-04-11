require 'spec_helper'
require 'rails_helper'

describe StudentRequestsController, :type => :controller do
  describe "Create Student Request: " do
    context 'on a a student request that already exists' do
          it 'should set the appropriate variable' do
            #Given
            student = FactoryGirl.create(:student)
            Student.should_receive(:where).once.and_return([student])
            student_request = FactoryGirl.create(:student_request)
            #StudentRequest.should_receive(:exists?).with(:uin => student_request.uin, :course_id => student_request.course_id, :section_id => student_request.section_id).once.and_return(true)
            StudentRequest.should_receive(:exists?).once.and_return(true)
            Major.should_receive(:pluck).with(:major_id).once.and_return("Computer Science")

            #When
            post :create, :student_request => {:name => student_request.name,
                                               :uin => student_request.uin,
                                               :major => student_request.major,
                                               :classification => student_request.classification,
                                               :email => student_request.email,
                                               :request_semester => student_request.request_semester,
                                               :course_id => student_request.course_id,
                                               :phone => student_request.phone,
                                                :section_id => 505}

          #THEN
          expect(flash[:warning]).to eq("You have already submitted a force request for CSCE" + student_request.course_id.to_s + "-505")

          assigns(:classificationList).should eq(StudentRequest::CLASSIFICATION_LIST)
          assigns(:YearSemester).should eq(StudentRequest::YEAR_SEMESTER)
          assigns(:requestSemester).should eq(StudentRequest::REQUEST_SEMESTER)
          assigns(:majorList).should eq("Computer Science")
          assert_template 'new'
        end
    end

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
          expect(flash[:notice]).to eq("Student Request was successfully withdrawn.")
      end

      it "should fail to update state to WITHDRAWN_STATE" do
        #GIVEN
        student_request = FactoryGirl.create(:student_request)
        student_request.state = StudentRequest::APPROVED_STATE
        StudentRequest.should_receive(:find).once.and_return(student_request)

        #when
        put :update, :id => 14

        #Then
        expect(flash[:warning]).to eq("Student Request cannot be withdrawn.")




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

  describe 'Load Admin Page' do
    it "should redirect to home page for wrong UIN" do
      #GIVEN
      request.session[:uin] = nil

      get :adminview

      assert_response :redirect, :action => root_path
    end

    it "should load all of the states when state_selected is nil in both the session and the params" do
      #Given
      request.session[:uin] = 12345678
      request.session[:state_sel] = {StudentRequest::ACTIVE_STATE => true}

      #When
      get :adminview

      #THEN

      assigns(:state_selected).should eq( StudentRequest::ACTIVE_STATE => true,
        StudentRequest::REJECTED_STATE => false,
         StudentRequest::APPROVED_STATE => false,
         StudentRequest::HOLD_STATE => false)

    end

    it "should load all of the states when state_selected is passed in through params"  do
      #Given
      request.session[:uin] = 12345678

      #When
      get :adminview, :state_sel => {StudentRequest::ACTIVE_STATE => true}

      #THEN

      assigns(:state_selected).should eq( StudentRequest::ACTIVE_STATE => true,
        StudentRequest::REJECTED_STATE => false,
         StudentRequest::APPROVED_STATE => false,
         StudentRequest::HOLD_STATE => false)

         expect(request.session[:state_sel]).to eq( ActionController::Parameters.new("Active" => "true"))
    end

    it "should set the priority when params has a :priority_sel but session does not"  do
      #Given
      request.session[:uin] = 12345678
      request.session[:priority_sel] = {StudentRequest::VERYHIGH_PRIORITY => true}


      #When
      get :adminview

      #THEN

      assigns(:priority_selected).should eq(StudentRequest::VERYHIGH_PRIORITY => true,
        StudentRequest::HIGH_PRIORITY => false,
        StudentRequest::NORMAL_PRIORITY => false,
        StudentRequest::LOW_PRIORITY => false,
        StudentRequest::VERYLOW_PRIORITY => false)

         expect(request.session[:priority_sel]).to eq("Very High" => true)
    end

    it "should set the priority when neither  params nor session has :priority_sel"  do
      #Given
      request.session[:uin] = 12345678
      request.session[:priority_sel] = {StudentRequest::VERYHIGH_PRIORITY => true}


      #When
      get :adminview

      #THEN

      assigns(:priority_selected).should eq(StudentRequest::VERYHIGH_PRIORITY => true,
        StudentRequest::HIGH_PRIORITY => false,
        StudentRequest::NORMAL_PRIORITY => false,
        StudentRequest::LOW_PRIORITY => false,
        StudentRequest::VERYLOW_PRIORITY => false)

         expect(request.session[:priority_sel]).to eq("Very High" => true)
    end

    it "should set the priority from the params when available"  do
      #Given
      request.session[:uin] = 12345678
      #request.session[:priority_sel] = {StudentRequest::VERYHIGH_PRIORITY => true}


      #When
      get :adminview, :priority_sel => {StudentRequest::VERYHIGH_PRIORITY => true}

      #THEN

      assigns(:priority_selected).should eq(StudentRequest::VERYHIGH_PRIORITY => true,
        StudentRequest::HIGH_PRIORITY => false,
        StudentRequest::NORMAL_PRIORITY => false,
        StudentRequest::LOW_PRIORITY => false,
        StudentRequest::VERYLOW_PRIORITY => false)

         expect(request.session[:priority_sel]).to eq(ActionController::Parameters.new("Very High" => "true"))
    end
  end

  describe "updaterequestbyadmin" do
    it "should issue a flash warning when attempting to update an already withdrawn request" do

        student_request = FactoryGirl.create(:student_request)
        student_request.state = StudentRequest::WITHDRAWN_STATE
        StudentRequest.should_receive(:find).once.and_return(student_request)

        put :updaterequestbyadmin, :id => 14

        expect(flash[:warning]).to eq("Request has already been withdrawn by student. Please refresh your Page.")
    end

    it "should add admin notes if available" do
      student_request = FactoryGirl.create(:student_request)
      student_request.state = StudentRequest::ACTIVE_STATE
      StudentRequest.should_receive(:find).once.and_return(student_request)

      put :updaterequestbyadmin, {:id => 14, :notes_for_myself => "These are my admin notes."}

      expect(assigns(:student_request).admin_notes).to eq("These are my admin notes.")
    end

    it "should add notes to a student if available" do
      student_request = FactoryGirl.create(:student_request)
      student_request.state = StudentRequest::ACTIVE_STATE
      StudentRequest.should_receive(:find).once.and_return(student_request)

      put :updaterequestbyadmin, {:id => 14, :notes_for_student => "These are my notes to a student."}

      expect(assigns(:student_request).notes_to_student).to eq("These are my notes to a student.")
    end

  end

  describe "login" do
    #post 'student_requests/login' => 'student_requests#login'
    it "should set current_state to nil when logging in" do
      Admin.should_receive(:where).once.and_return([nil])

      post :login, params: { 'session' => { :user => "admin"}}

       expect(request.session[:current_state]).to be_nil
    end

    it "should display a flash warning when account doesn't exist" do
      Admin.should_receive(:where).once.and_return([nil])

      post :login, params: { 'session' => { :user => "admin"}}

      expect(flash[:warning]).to eq("Your Email or Password is Incorrect.")
    end

    it "should redirect to rooth path when account doesn't exist" do
      Admin.should_receive(:where).once.and_return([nil])

      post :login, params: { 'session' => { :user => "admin"}}

      assert_response :redirect, :action => root_path
    end
  end
end
