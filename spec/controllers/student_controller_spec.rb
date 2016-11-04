require 'spec_helper'
require 'rails_helper'

describe StudentRequestsController, :type => :controller do
	describe 'get index' do
	    before :each do
		  @fake_students = [double('student1'), double('student2')]
	    end
	    it 'should call the model method that retrieves all Users' do
	      StudentRequest.should_receive(:where).with({state: StudentRequest::ACTIVE_STATE}).once.and_return(@fake_students)
	      get :index
	    end
	    
	    describe 'after valid search' do
	      before :each do
		    @fake_students = [double('student1'), double('student2')]
		    StudentRequest.should_receive(:where).with({state: StudentRequest::ACTIVE_STATE}).once.and_return(@fake_students)
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
end
