require 'spec_helper'
require 'rails_helper'

describe StudentRequestsController, :type => :controller do
	describe 'get index' do
	    before :each do
		  @fake_students = [double('student1'), double('student2')]
		  @request.session[:uin] = '3213213'
	    end
	    it 'should call the model method that retrieves all Users' do
	      StudentRequest.should_receive(:where).with({uin: @request.session[:uin]}).once.and_return(@fake_students)
	      get :index
	    end
	    
	    describe 'after valid search' do
	      before :each do
		    @fake_students = [double('student1'), double('student2')]
		    @request.session[:uin] = '3213213'
		    StudentRequest.should_receive(:where).with({uin: @request.session[:uin]}).once.and_return(@fake_students)
		    get :index
          end
	      
	      it 'should select the index template for rendering' do
		    response.should render_template('index')
	      end
	      
	      it 'should make the users results available to that template' do
		    assigns(:StudentRequest).should == @fake_users
	      end
	    end
	end
	
	describe 'new force request' do
	      before :each do
			get :new
	      end
	      
	      it 'should render create new force request page' do
			response.should render_template('new')
	      end
	end
	
	describe 'delete a force request' do
	    before :each do
	      @fake_student = FactoryGirl.create(:student_request)
	    end
	    
	    it 'should call the model method that retrieves the student request for that id and sets state to WITHDRAWN_STATE' do
	      StudentRequest.should_receive(:find).once.and_return(@fake_student)
	      put :update, id: @fake_student.id
	    end
	end
end
