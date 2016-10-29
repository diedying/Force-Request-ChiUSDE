require 'spec_helper'
require 'rails_helper'

describe StudentRequestsController, :type => :controller do
	describe 'get index' do
	    before :each do
		  #@fake_students = [double('student1'), double('student2')]
	      #student1 = StudentRequest.new
	      #student1.state = StudentRequest::ACTIVE_STATE
	      #student2 = StudentRequest.new
	      #student2.state = StudentRequest::ACTIVE_STATE
		  #mock_model("student1")
	    end
	    it 'should call the model method that retrieves all Users' do
	      #StudentRequest.should_receive(:all).once.and_return(stub_model(StudentRequest, state: StudentRequest::ACTIVE_STATE))
	      #StudentRequest.stub(:where).and_return(@fake_students)
	      #Array.any_instance.stub(:where).and_return(@fake_students)
	      #StudentRequest.should_receive(:all).once.and_return(@fake_students)
	      #get :index
	    end
	    
	    describe 'after valid search' do
	      before :each do
		    #StudentRequest.stub(:all).and_return(@fake_users)
		    #get :index
          end
	      
	      it 'should select the index template for rendering' do
		    #response.should render_template('index')
	      end
	      
	      it 'should make the users results available to that template' do
		    #assigns(:StudentRequest).should == @fake_users
	      end
	    end
	end    
end
