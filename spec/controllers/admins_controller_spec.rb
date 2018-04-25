require 'spec_helper'
require 'rails_helper'

describe AdminsController, :type => :controller do
    describe 'addAdmin' do
       context 'when correct params are passed in' do
         before :each do
           post :addAdmin, :admin_request => {:uin => 123006789, :name => "Henry Higgs", :password => "1234Henry"}
         end

         it 'should render a flash notice' do
            expect(flash[:notice]).to eq('Admin was successfully created.')
         end

         it 'should redirect to the adminview path' do
           assert_response :redirect, :action => 'student_requests_adminview_path'
         end
       end

       context 'when the incorrect params are passed in' do
         before :each do
           post :addAdmin, :admin_request => {:wrong_params => "No, really. The wrong params"}
         end

         it 'render a flash notice' do
           expect(flash[:warning]).to eq("Name can't be blank,Name is invalid,Uin can't be blank,Password can't be blank")

         end

         it 'should redirec to the advmin review path' do
           assert_response :redirect, :action => 'student_requests_adminview_path'
         end
       end

    end
end
